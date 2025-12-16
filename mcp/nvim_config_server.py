#!/usr/bin/env python
"""
MCP filesystem server exposing the Neovim config tree.
Requires `pip install mcp` (python implementation of the Model Context Protocol).
"""

from __future__ import annotations

import asyncio
import fnmatch
import os
import signal
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable

from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import ListResourcesResult, ListToolsResult, Resource

SERVER_NAME = "nvim-config"
ROOT = Path(os.environ.get("NVIM_CONFIG_ROOT", Path(__file__).resolve().parents[1])).resolve()

INCLUDE_PATTERNS = [
    "init.lua",
    "after/**",
    "lua/**",
    "README*.md",
    "*.md",
]

EXCLUDE_PATTERNS = [
    ".git/**",
]

server = Server(SERVER_NAME)


def _is_excluded(path: Path) -> bool:
    rel = path.relative_to(ROOT).as_posix()
    return any(fnmatch.fnmatch(rel, pat) for pat in EXCLUDE_PATTERNS)


def _iter_allowed_files() -> Iterable[Path]:
    seen: set[Path] = set()
    for pattern in INCLUDE_PATTERNS:
        for path in ROOT.glob(pattern):
            if not path.is_file():
                continue
            if _is_excluded(path):
                continue
            real = path.resolve()
            if real in seen:
                continue
            seen.add(real)
            yield real


def _validate_and_resolve(uri) -> Path:
    uri_str = str(uri)
    path = Path(uri_str.replace("file://", "")) if uri_str.startswith("file://") else Path(uri_str)
    resolved = path.resolve()
    resolved.relative_to(ROOT)  # raises ValueError if outside
    if _is_excluded(resolved):
        raise ValueError("Resource is excluded")
    return resolved


@server.list_resources()
async def list_resources() -> ListResourcesResult:
    resources = [
        Resource(
            uri=path.as_uri(),
            name=path.name,
            description=str(path.relative_to(ROOT)),
        )
        for path in _iter_allowed_files()
    ]
    return ListResourcesResult(resources=resources)


@server.list_tools()
async def list_tools() -> ListToolsResult:
    return ListToolsResult(tools=[])


@dataclass
class _Content:
    content: str
    mime_type: str | None = "text/plain"


@server.read_resource()
async def read_resource(uri: str):
    path = _validate_and_resolve(uri)
    text = path.read_text(encoding="utf-8", errors="replace")
    return [_Content(content=text)]


async def main():
    if not ROOT.exists():
        raise RuntimeError(f"Root does not exist: {ROOT}")
    init_opts = server.create_initialization_options()
    print(f"{SERVER_NAME} server ready on stdio, root={ROOT}")
    async with stdio_server() as (read_stream, write_stream):
        await server.run(read_stream, write_stream, init_opts)


if __name__ == "__main__":
    signal.signal(signal.SIGINT, lambda *_: os._exit(130))
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print(f"{SERVER_NAME} server stopped by KeyboardInterrupt", file=sys.stderr)
        os._exit(0)


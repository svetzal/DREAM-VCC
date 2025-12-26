#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path

from docling.datamodel.base_models import InputFormat
from docling.datamodel.pipeline_options import VlmPipelineOptions
from docling.datamodel.pipeline_options_vlm_model import ApiVlmOptions, ResponseFormat
from docling.document_converter import DocumentConverter, PdfFormatOption
from docling.pipeline.vlm_pipeline import VlmPipeline


def ollama_vlm_options(model: str, prompt: str) -> ApiVlmOptions:
    # Docling’s example uses Ollama’s OpenAI-compatible endpoint:
    # http://localhost:11434/v1/chat/completions :contentReference[oaicite:2]{index=2}
    return ApiVlmOptions(
        url="http://localhost:11434/v1/chat/completions",
        params={"model": model},
        prompt=prompt,
        timeout=1800,
        scale=1.0,
        response_format=ResponseFormat.MARKDOWN,  # request Markdown :contentReference[oaicite:3]{index=3}
    )


def convert_pdf_to_markdown(pdf_path: Path, model: str) -> str:
    pipeline_options = VlmPipelineOptions(
        enable_remote_services=True  # required when calling remote VLM endpoints :contentReference[oaicite:4]{index=4}
    )

    pipeline_options.vlm_options = ollama_vlm_options(
        model=model,
        prompt=(
            "OCR the full page to markdown.\n"
            "Do not hallucinate. Preserve headings, lists, and tables.\n"
        ),
    )

    converter = DocumentConverter(
        format_options={
            InputFormat.PDF: PdfFormatOption(
                pipeline_cls=VlmPipeline,
                pipeline_options=pipeline_options,
            )
        }
    )

    result = converter.convert(source=str(pdf_path))
    return result.document.export_to_markdown()


def main() -> None:
    ap = argparse.ArgumentParser(description="Docling VLM -> Markdown via Ollama")
    ap.add_argument(
        "--model",
        default="qwen3-vl:30b",
        help="Ollama model name (default: qwen3-vl:30b)",
    )
    args = ap.parse_args()

    # Find all PDF files in current directory
    current_dir = Path(".")
    pdf_files = list(current_dir.glob("*.pdf"))

    if not pdf_files:
        print("No PDF files found in current directory")
        return

    print(f"Found {len(pdf_files)} PDF file(s)")

    for pdf_path in pdf_files:
        # Create output filename
        out_path = pdf_path.with_suffix(".md")

        # Skip if markdown file already exists
        if out_path.exists():
            print(f"Skipping {pdf_path.name} (markdown already exists)")
            continue

        print(f"Processing {pdf_path.name}...")
        md = convert_pdf_to_markdown(pdf_path, args.model)
        out_path.write_text(md, encoding="utf-8")
        print(f"  -> Created {out_path.name}")


if __name__ == "__main__":
    main()

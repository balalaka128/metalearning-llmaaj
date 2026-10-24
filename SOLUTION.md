# Team Pinoqio: solution

Our solution is in [`judge/`](judge/), built by the [`Dockerfile`](Dockerfile) in the repository root.
Full instructions, configuration and results: [`judge/README.md`](judge/README.md).
Source of truth and the rest of the project (MIT): https://github.com/bioztar/pinoqio

## Build and run

```sh
python3 src/prepare_inputs.py --train data/public_train.csv --test data/public_test.csv --out-dir in
docker build -t pinoqio-judge .
docker run --rm -e GEMINI_API_KEY -v "$PWD/in:/input" -v "$PWD/artifacts:/artifacts" pinoqio-judge adapt
docker run --rm -e GEMINI_API_KEY -v "$PWD/in:/input" -v "$PWD/artifacts:/artifacts" -v "$PWD/out:/output" pinoqio-judge eval
python3 src/evaluate.py --test data/public_test.csv --predictions out/predictions.csv
```

- `adapt` reads `/input/train.jsonl` and writes to `/artifacts`; the explanation for the jury is `/artifacts/explanation.md`.
- `eval` reads `/input/test.jsonl` and `/artifacts`, writes `/output/predictions.csv` (`item_id,label`).
- Configuration is by environment variables only. Required: `GEMINI_API_KEY` (Gemma 4 via the Gemini API). Optional: see `judge/README.md`.
- Model: `gemma-4-26b-a4b-it`. At the free-tier limit of about 15 requests per minute, `adapt` on 190 examples takes about 10 minutes and `eval` on 296 about 22 minutes; set `JUDGE_RPM` higher if your key allows it.

# COBOL Exercises Workspace

This repo collects progressively more advanced COBOL samples—starting with the tiniest `DISPLAY` and ending with fuzzy matching + reporting workloads. Every program now carries an inline docstring, while this README keeps the quick facts handy.

## Program catalog (TL;DR)

| Source | What it demonstrates | Reads | Writes |
| --- | --- | --- | --- |
| `hello.cob` | Literal "Hello world" display | — | — |
| `hello_2.cob` | Greeting stored in WORKING-STORAGE | — | — |
| `Opgave2.cbl` | One hard-coded customer record printed field-by-field | — | — |
| `Opgave3.cbl` | String concatenation + space normalization for names | — | — |
| `Opgave4.cbl` | Nested customer/account group items dumped in one DISPLAY | — | — |
| `Opgave5.cbl` | Using the shared `KUNDER.cpy` copybook for structure definitions | — | — |
| `Opgave6.cbl` | Sequential read of `data/input/kunder_2.txt` with simple output | `data/input/kunder_2.txt` | — |
| `Opgave7.cbl` | Stream copy from customer file to `data/output/output.txt` | `data/input/kunder_2.txt` | `data/output/output.txt` |
| `Opgave7_2.cbl` | Hand-built multi-line address blocks | `data/input/kunder_2.txt` | `data/output/output_2.txt` |
| `Opgave7_3.cbl` | Reusable formatting paragraphs for address lines | `data/input/kunder_2.txt` | `data/output/output_2.txt` |
| `Opgave8.cbl` | On-demand account lookup per customer record | `data/input/kunder_2.txt`, `data/input/KUNDEKONTO.txt` | `data/output/kundeoplysninger.txt` |
| `Opgave8_test.cbl` | Prototype for using OCCURS tables while joining account data | `data/input/kunder_2.txt`, `data/input/KUNDEKONTO.txt` | `data/output/kundeoplysninger.txt` |
| `Opgave9.cbl` | Optimized join that preloads account records into memory | `data/input/kunder_2.txt`, `data/input/KUNDEKONTO.txt` | `data/output/kundeoplysninger.txt` |
| `Opgave10.cbl` | Loads all banks + transactions and emits a detailed report per CPR | `data/input/Banker.txt`, `data/input/Transaktioner_gen.txt` | `data/output/rapport_opg_10.txt` |
| `Opgave12.cob` | Levenshtein-based customer vs. sanction matching with scoring | `data/input/KundeOplysninger_opg12.txt`, `data/input/SanctionList_opg12.txt` | `data/output/rapport.txt` |

## Quick start

### Build & run a program

Two helper scripts under `scripts/build` take care of compiler flags, copybook paths, and the local GnuCOBOL toolchain:

- `cobbuildquick.bat <ProgramName>` – compile **and execute** `src/cobol/<ProgramName>.cbl|.cob`, dropping the EXE into `bin/`.
- `cobbuild.bat <ProgramName>` – compile only.

Example commands from the repo root:

```powershell
# Compile + run the fuzzy-matching sample
./scripts/build/cobbuildquick.bat Opgave12

# Compile (skip run) for the transaction report
./scripts/build/cobbuild.bat Opgave10
```

Both helpers automatically:

- Add `src/copybooks` to the INCLUDE path.
- Output executables to `bin/<ProgramName>.exe`.
- Prefill `%PATH%` with the bundled GnuCOBOL binaries located under `%LOCALAPPDATA%`.

## Repository layout

```
cobol/
├─ bin/                    # Compiled executables
├─ data/
│  ├─ input/               # Sample + generated input files
│  └─ output/              # Reports created by the COBOL programs
├─ docs/                   # Extra documentation (currently blank)
├─ scripts/
│  ├─ build/               # Windows build helpers
│  └─ python/              # Data generation utilities
└─ src/
   ├─ cobol/               # All .cbl/.cob sources
   └─ copybooks/           # Shared copybooks (KUNDER, KONTOOPL, etc.)
```

## Data & fixture generation

Most programs keep their inputs under `data/input` and write results to `data/output`. When you need fresh fraud/sanction fixtures, regenerate them with:

```powershell
python ./scripts/python/GenFraudInfo.py
```

The script autodetects the repo root and rewrites:

- `data/input/KundeOplysninger_opg12.txt`
- `data/input/SanctionList_opg12.txt`

## Source recaps

- **`hello.cob`** – Minimal sanity check that simply displays a literal string.
- **`hello_2.cob`** – Stores the greeting in WORKING-STORAGE first to show variable DISPLAY.
- **`Opgave2.cbl`** – Fills a hard-coded customer struct and prints each field to the console.
- **`Opgave3.cbl`** – Builds `FULL-NAME`, removes duplicate spaces, and shows the cleaned value next to other fields.
- **`Opgave4.cbl`** – Demonstrates nested group items that encompass customer + account data before displaying the entire hierarchy.
- **`Opgave5.cbl`** – Imports `KUNDER.cpy` so the shared layout can be populated once and displayed as a record.
- **`Opgave6.cbl`** – Streams `data/input/kunder_2.txt`, printing each person's name and street; it's the first example that touches disk.
- **`Opgave7.cbl`** – Copies every customer row to `data/output/output.txt` while echoing key fields to STDOUT.
- **`Opgave7_2.cbl`** – Emits four-line address blocks (ID, name, street, city) for each customer into `output_2.txt`.
- **`Opgave7_3.cbl`** – Refactors the formatting logic into dedicated `FORMAT-*` paragraphs before writing the address block.
- **`Opgave8.cbl`** – Adds an on-demand lookup into `data/input/KUNDEKONTO.txt` so customers and accounts are joined while writing `kundeoplysninger.txt`.
- **`Opgave8_test.cbl`** – A playground version that experiments with a tiny OCCURS table for account data while keeping the same inputs/outputs.
- **`Opgave9.cbl`** – Preloads all accounts into memory once, then uses the cached table to write the same joined output more efficiently.
- **`Opgave10.cbl`** – Reads all banks and transactions up front, then emits a consolidated customer/bank/transaction report to `rapport_opg_10.txt`.
- **`Opgave12.cob`** – Uses Levenshtein distance plus weighted scoring to match customers against a sanction list, producing `data/output/rapport.txt`.

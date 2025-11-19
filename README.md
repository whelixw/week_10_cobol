# COBOL Exercises Workspace

This repo now follows a simple, repeatable layout so source code, copybooks, build helpers, and data stay organized:

```
cobol/
├─ bin/                    # Compiled executables
├─ data/
│  ├─ input/               # Generated + sample input files
│  └─ output/              # Reports and other outputs
├─ docs/                   # Additional documentation (empty for now)
├─ scripts/
│  ├─ build/               # Windows build helpers
│  └─ python/              # Data generation utilities
└─ src/
   ├─ cobol/               # All .cbl/.cob programs
   └─ copybooks/           # Shared copybooks
```

## Building

Two Windows batch helpers live under `scripts/build`:

- `cobbuildquick.bat <ProgramName>` – compile **and run** `src/cobol/<ProgramName>.cbl|.cob`, writing the executable to `bin/`.
- `cobbuild.bat <ProgramName>` – compile only (same inputs/outputs) and skip execution.

Both scripts automatically:
- Add `src/copybooks` to the COPY/INCLUDE path.
- Output the executable to `bin/<ProgramName>.exe`.
- Use the local GnuCOBOL toolchain already installed under `%LOCALAPPDATA%`.

Example from the repo root:

```powershell
# Compile + run
./scripts/build/cobbuildquick.bat opgave_12

# Compile only
./scripts/build/cobbuild.bat Opgave10
```

## Test data generation

`scripts/python/GenFraudInfo.py` now detects the repo root automatically and writes both input files into `data/input/`. Run it with the default system Python:

```powershell
python ./scripts/python/GenFraudInfo.py
```

This refreshes:
- `data/input/KundeOplysninger_opg12.txt`
- `data/input/SanctionList_opg12.txt`

## Program notes

`src/cobol/opgave_12.cob` now reads both customer and sanction files through dedicated copybooks:
- `src/copybooks/kunde-file-control.cpy`
- `src/copybooks/kunde-file-section.cpy`
- `src/copybooks/sanction-file-control.cpy`
- `src/copybooks/sanction-file-section.cpy`

The readers simply stream each file and display the ID + primary name (plus the first alias for sanctions). Edit the copybooks if the record layout changes.

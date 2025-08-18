# Fortify Static Code Analysis

This project includes Fortify Static Code Analyzer (SCA) integration for security vulnerability detection.

## Overview

Fortify scanning is automatically integrated into the Jenkins CI/CD pipeline and can also be run locally for development.

## Jenkins Integration

The Fortify scan runs automatically after the test phase in the Jenkins pipeline via the `rubyBuilder.fortifyScan()` call in `Jenkinsfile_CNP`. This uses Fortify on Demand (FoD) cloud service with credentials managed through Azure Key Vault.

## Local Usage

To run Fortify scans locally (requires Fortify SCA installation):

```bash
# Run a complete scan
bundle exec rake fortify

# Or run individual steps
bundle exec rake fortify:scan    # Perform the scan
bundle exec rake fortify:upload  # Upload results to FoD (requires credentials)
```

## Configuration

- **Scan Configuration**: `.fortify` file contains analysis settings
- **Build ID**: `hwf-publicapp`
- **Included Directories**: `app/`, `lib/`, `config/`
- **Excluded Directories**: `spec/`, `test/`, `features/`, `tmp/`, `log/`, `vendor/`, `node_modules/`

## Results

Scan results are stored in `fortify_results/`:
- `hwf-publicapp.fpr` - Fortify Project Results file
- `hwf-publicapp.html` - HTML report (if ReportGenerator is available)

These files are ignored by git to prevent committing scan artifacts.

## Requirements

The Jenkins environment includes the necessary Fortify SCA tools. For local development:
- Fortify Static Code Analyzer (SCA)
- Fortify CLI tools (optional, for FoD integration)

## Credentials

Fortify on Demand credentials are managed through:
- **Jenkins**: Azure Key Vault integration via `withFortifySecrets`
- **Environment Variables**: `FORTIFY_USER_NAME` and `FORTIFY_PASSWORD`

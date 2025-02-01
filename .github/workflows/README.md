<div align="center">
  <h1>Workflows :joystick:</h1>
</div>

<p align="center">
  <a href="#overview"><b>Overview</b></a>
  &nbsp;&nbsp;&mdash;&nbsp;&nbsp;
  <a href="#prerequisite"><b>Prerequisite</b></a>
  &nbsp;&nbsp;&mdash;&nbsp;&nbsp;
  <a href="#explanation"><b>Explanation</b></a>
  &nbsp;&nbsp;&mdash;&nbsp;&nbsp;
  <a href="#conclusion"><b>Conclusion</b></a>
</p>

## Overview

This repository contains several GitHub Actions workflows to automate various tasks such as code quality checks, building and deploying the application, and generating previews for pull requests. The workflows are defined in the
`workflows` directory and include:

1. **CodeQL Analysis**: Runs CodeQL analysis on push and pull request events to the `main` branch to identify potential security vulnerabilities.
2. **Lint and Format Check**: Validates code formatting and linting on push and pull request events.
3. Include two workflows:
   - **Switch Operating Environment**: Uploads pull request metadata to be used by other workflows.
   - **Preview App for Pull Request**: Generates a preview of the application for pull requests to the `main` branch.
4. **On Push To main**: Triggers on push events to the `main` branch to check for native code changes and build or update the application accordingly.

## Prerequisite

To run these workflows, you need to configure the following secrets in your GitHub repository:

- `EXPO_TOKEN`: An Expo token to authenticate with Expo services.
- `GITHUB_TOKEN`: A GitHub token to allow the workflows to interact with the GitHub API (automatically provided by GitHub Actions).

## Explanation

### CodeQL Analysis

> **File**: [`codeql-analysis.yml`](codeql-analysis.yml)

**Purpose**: This workflow runs CodeQL analysis on push and pull request events to the `main` branch to identify potential security vulnerabilities.

**Steps**:

1. **Checkout repository**: Checkout the repository.
2. **Initialize CodeQL**: Initialize CodeQL with the specified languages (JavaScript and TypeScript).
3. **Perform CodeQL Analysis**: Run the CodeQL analysis.

### Lint and Format Check

> **File**: [`lint-format-check.yml`](lint-format-check.yml)

**Purpose**: This workflow validates code formatting and linting on push and pull request events.

**Steps**:

1. **Checkout code**: Checkout the repository.
2. **Set up Node.js**: Set up Node.js.
3. **Install dependencies**: Install project dependencies.
4. **Run ESLint**: Run ESLint to check for linting errors.
5. **Check code formatting with Prettier**: Check code formatting using Prettier.
6. **Detect unformatted files**: Detect unformatted files and check their formatting.
7. **Success notification**: Notify if all checks pass.
8. **Failure notification**: Notify if any checks fail.

### Switch Operating Environment

> **File**: [`workflow_trigger.yml`](workflow_trigger.yml)

**Purpose**: This workflow uploads pull request metadata to be used by other workflows.

**Steps**:

1. **Save PR Metadata**: Save the pull request metadata to a JSON file.
2. **Upload Metadata as Artifact**: Upload the metadata as an artifact.

### Preview App for Pull Request

> **File**: [`preview-on-pr.yml`](preview-on-pr.yml)
>
> **Info**: This workflow obtains environment variables through the execution results of "Switch Operating Environment".

**Purpose**: This workflow generates a preview of the application for pull requests to the `main` branch.

**Steps**:

1. **Download PR Metadata**: Download the pull request metadata.
2. **Load Environment Variables from JSON**: Load environment variables from the downloaded metadata.
3. **Checkout code**: Checkout the repository.
4. **Set up Node.js**: Set up Node.js.
5. **Install dependencies**: Install project dependencies.
6. **Setup Expo**: Set up Expo.
7. **Check for Native Code Changes**: Check for native code changes.
8. **Generate Update Message**: Generate a message for the update.
9. **Create Development Update For Preview**: Create a development update for preview if no native changes are detected.
10. **Post Comment in PR**: Post a comment in the pull request with the preview details.
11. **Build Full App**: Build the full app if native changes are detected.

### On Push To main

> **File**: [`build-on-push.yml`](build-on-push.yml)

**Purpose**: This workflow is triggered on push events to the `main` branch. It checks for native code changes and either runs an EAS development build or an EAS update based on the changes detected.

**Steps**:

1. **Check Native Code Changes**:
   - Checkout the repository.
   - Set up Node.js.
   - Install dependencies.
   - Check for native code changes using the `expo/expo-github-action/fingerprint` action.
2. **EAS Build or Update**:
   - Checkout the repository.
   - Set up Node.js.
   - Set up Expo.
   - Install dependencies.
   - Run an EAS development build if native changes are detected.
   - Run an EAS update if no native changes are detected.

## Conclusion

These workflows help automate various tasks in the development lifecycle, ensuring code quality, security, and providing easy previews for pull requests. Make sure to configure the required secrets in your GitHub repository to enable these workflows.

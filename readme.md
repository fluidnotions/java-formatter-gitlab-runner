# Java Code Formatter with Google Java Format

This Docker image provides an automated Java code formatter using Google Java Format inside a GitLab CI/CD Runner. It ensures all Java files in a repository conform to the Google Java Style Guide before merging.

## Features
- Based on Amazon Corretto JDK 21
- Pre-installed Google Java Format v1.25.2
- Includes Git for committing formatted files
- Designed for GitLab CI/CD pipelines
- Detects merge request pipelines and pushes to the correct branch

## Usage in GitLab CI/CD
To integrate this into your GitLab CI/CD pipeline, use the following job configuration:

```yaml
stages:
  - format-fix

format-fix:
  image: your-docker-hub-username/java-formatter:latest
  tags:
    - java-formatter
  stage: format-fix
  script:
    - /usr/local/bin/format-and-commit.sh
  only:
    - merge_requests
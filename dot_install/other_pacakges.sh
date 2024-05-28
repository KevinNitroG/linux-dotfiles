#!/bin/bash

PIP_PACKAGES=(
  'ruff'
  'cpplint'
)

NPM_PACKAGES=(
  'markdownlint'
  'commitizen'
)

pip intsall "${PIP_PACKAGES[@]}"
npm install -g "${NPM_PACKAGES[@]}"

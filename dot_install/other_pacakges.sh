#!/bin/bash

PIP_PACKAGES=(
)

NPM_PACKAGES=(
  'commitizen'
)

pip intsall "${PIP_PACKAGES[@]}"
npm install -g "${NPM_PACKAGES[@]}"

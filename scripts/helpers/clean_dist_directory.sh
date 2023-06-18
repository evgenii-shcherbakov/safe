#!/usr/bin/env bash

DIST_FOLDER=${DIST_FOLDER:-$1}

clean_dist_directory() {
  rm -rf "$DIST_FOLDER"
  mkdir "$DIST_FOLDER"
}

clean_dist_directory

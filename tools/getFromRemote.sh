#!/bin/bash

# Dossier monté par GVFS (adapte ce nom si nécessaire)
GVFS_PATH="/run/user/$(id -u)/gvfs/sftp:host=1.studio.boardgamearena.com,port=2022"
REMOTE_DIR="$GVFS_PATH/dummyoms"
LOCAL_DIR="../game"

# Vérifie que le point de montage est disponible
if [ ! -d "$REMOTE_DIR" ]; then
  echo "Erreur : le dossier distant '$REMOTE_DIR' n'est pas monté."
  echo "Connecte-toi d'abord via Fichiers > Autres emplacements."
  exit 1
fi

# Crée le dossier local si besoin
mkdir -p "$LOCAL_DIR"

# Copie récursive des fichiers
cp -r "$REMOTE_DIR"/* "$LOCAL_DIR"

echo "✔️ Fichiers copiés dans : $LOCAL_DIR"

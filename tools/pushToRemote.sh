#!/bin/bash

# Dossier local à envoyer
LOCAL_DIR="../game"

# Dossier distant (SFTP monté via Nautilus/GVFS)
GVFS_PATH="/run/user/$(id -u)/gvfs/sftp:host=1.studio.boardgamearena.com,port=2022"
REMOTE_DIR="$GVFS_PATH/dummyoms"

# Vérification des chemins
if [ ! -d "$LOCAL_DIR" ]; then
  echo "Erreur : le dossier local '$LOCAL_DIR' n'existe pas."
  exit 1
fi

if [ ! -d "$REMOTE_DIR" ]; then
  echo "Erreur : le dossier distant '$REMOTE_DIR' n'est pas accessible."
  echo "Connecte-toi via Nautilus avant d'exécuter ce script."
  exit 2
fi

# Copie des fichiers
cp -r "$LOCAL_DIR"/* "$REMOTE_DIR"

echo "✔️ Dossier '$LOCAL_DIR' copié vers '$REMOTE_DIR'"

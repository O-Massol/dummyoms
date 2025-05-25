#!/bin/bash

# Configuration
AUTH_FILE="../ignored/sftpAuth"
REMOTE_USER="omassol"
REMOTE_HOST="1.studio.boardgamearena.com"
REMOTE_PORT="2022"
REMOTE_DIR="/dummyoms"
LOCAL_DIR="../game"

# Vérification du fichier contenant le mot de passe
if [ ! -f "$AUTH_FILE" ]; then
  echo "Erreur : le fichier '$AUTH_FILE' est introuvable."
  exit 1
fi

PASSWORD=$(<"$AUTH_FILE")

# Création du dossier local si nécessaire
mkdir -p "$LOCAL_DIR"

# Fichier batch temporaire pour SFTP
BATCH_FILE=$(mktemp)
cat <<EOF > "$BATCH_FILE"
cd $REMOTE_DIR
lcd $LOCAL_DIR
mget -r *
bye
EOF

# Exécution de la commande SFTP avec sshpass
sshpass -p "$PASSWORD" sftp -oStrictHostKeyChecking=no -oPort=$REMOTE_PORT -b "$BATCH_FILE" "$REMOTE_USER@$REMOTE_HOST"

# Nettoyage
rm "$BATCH_FILE"

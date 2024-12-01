# Étape 1 : Utiliser l'image Node.js officielle pour le build
FROM node:18 AS build

# Définit le répertoire de travail
WORKDIR /usr/src/app

# Copier les fichiers package.json et package-lock.json pour installer les dépendances
COPY package*.json ./

# Configurer NPM pour éviter les erreurs réseau
RUN npm config set registry https://registry.npmjs.org/
RUN npm config set strict-ssl false
RUN npm config set fetch-retries 5
RUN npm config set fetch-retry-mintimeout 20000
RUN npm config set fetch-retry-maxtimeout 120000

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Compiler l'application Angular pour la production
RUN npm run build

# Étape 2 : Utiliser Nginx pour servir les fichiers statiques
FROM nginx:alpine

# Copier les fichiers du dossier browser vers Nginx
COPY --from=build /usr/src/app/dist/angular-pipeline/browser /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]

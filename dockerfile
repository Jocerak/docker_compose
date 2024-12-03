# Utilisation de l'image officielle PHP avec Apache
FROM php:8.2-apache

# Installer les extensions PHP nécessaires
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mysqli

# Activer le module Apache mod_rewrite pour le support de URL réécrites
RUN a2enmod rewrite

# Copier le code de votre application dans le répertoire /var/www/html de l'image
COPY app /var/www/html/

# Définir le répertoire de travail
WORKDIR /var/www/html

# Exposer le port 80 pour accéder à l'application
EXPOSE 80

# Démarrer Apache en mode avant-plan
CMD ["apache2-foreground"]

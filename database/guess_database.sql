SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Guess` ;
SHOW WARNINGS;
USE `Guess` ;

-- -----------------------------------------------------
-- Table `Guess`.`Image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Image` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `extension` VARCHAR(255) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `alt` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Entreprise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Entreprise` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Entreprise` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `adresse` VARCHAR(255) NULL,
  `descriptif` TEXT NULL,
  `tel` VARCHAR(255) NULL,
  `mail` VARCHAR(255) NULL,
  `logo` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Entreprise_Image1_idx` (`logo` ASC),
  CONSTRAINT `fk_Entreprise_Image1`
    FOREIGN KEY (`logo`)
    REFERENCES `Guess`.`Image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Offre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Offre` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Offre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `header` VARCHAR(255) NOT NULL,
  `domaine` VARCHAR(255) NOT NULL,
  `descripftif` TEXT NOT NULL,
  `debut` DATE NOT NULL,
  `delaiCandidature` DATETIME NULL,
  `prime` TINYINT(1) NULL,
  `dureeStage` VARCHAR(255) NULL,
  `lettreMotivation` TINYINT(1) NULL,
  `entreprise` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_offre_entreprise1_idx` (`entreprise` ASC),
  CONSTRAINT `fk_offre_entreprise1`
    FOREIGN KEY (`entreprise`)
    REFERENCES `Guess`.`Entreprise` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Utilisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Utilisateur` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Utilisateur` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `prenom` VARCHAR(255) NOT NULL,
  `adresse` VARCHAR(255) NULL,
  `date_naissance` VARCHAR(255) NULL,
  `ville` VARCHAR(255) NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `tel` VARCHAR(255) NULL,
  `sexe` CHAR NOT NULL,
  `trombi` INT NULL,
  `avatar` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Utilisateur_Image1_idx` (`trombi` ASC),
  INDEX `fk_Utilisateur_Image2_idx` (`avatar` ASC),
  CONSTRAINT `fk_Utilisateur_Image1`
    FOREIGN KEY (`trombi`)
    REFERENCES `Guess`.`Image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_Image2`
    FOREIGN KEY (`avatar`)
    REFERENCES `Guess`.`Image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Forum_categorie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Forum_categorie` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Forum_categorie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `ordre` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ordre_UNIQUE` (`ordre` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Forum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Forum` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Forum` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categorie` INT NOT NULL,
  `createur` INT NOT NULL,
  `nom` VARCHAR(255) NOT NULL,
  `descritpion` TEXT NOT NULL,
  `ordre` VARCHAR(255) NOT NULL,
  `lastPostId` INT NOT NULL,
  `topic` INT NOT NULL,
  `post` INT NOT NULL,
  `authView` TINYINT NOT NULL,
  `authPost` TINYINT NOT NULL,
  `authTopic` TINYINT NOT NULL,
  `authAnnonce` TINYINT NOT NULL,
  `authModo` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Forum_Utilisateur1_idx` (`createur` ASC),
  INDEX `fk_Forum_Forum_categorie1_idx` (`categorie` ASC),
  CONSTRAINT `fk_Forum_Utilisateur1`
    FOREIGN KEY (`createur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Forum_Forum_categorie1`
    FOREIGN KEY (`categorie`)
    REFERENCES `Guess`.`Forum_categorie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Stage` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Stage` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `etat` VARCHAR(255) NOT NULL,
  `debut` DATE NOT NULL,
  `fin` DATE NULL,
  `offre` INT NOT NULL,
  `forum` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stage_offre1_idx` (`offre` ASC),
  INDEX `fk_Stage_forum1_idx` (`forum` ASC),
  CONSTRAINT `fk_stage_offre1`
    FOREIGN KEY (`offre`)
    REFERENCES `Guess`.`Offre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stage_forum1`
    FOREIGN KEY (`forum`)
    REFERENCES `Guess`.`Forum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Annonce`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Annonce` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Annonce` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(255) NOT NULL,
  `contenu` LONGTEXT NOT NULL,
  `dateCreation` DATETIME NOT NULL,
  `dateEdition` DATETIME NULL,
  `auteur` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_anoonce_Utilisateur1_idx` (`auteur` ASC),
  CONSTRAINT `fk_anoonce_Utilisateur1`
    FOREIGN KEY (`auteur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Topic` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Topic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `forum` INT NOT NULL,
  `createur` INT NOT NULL,
  `titre` VARCHAR(255) NOT NULL,
  `dateCreation` DATETIME NOT NULL,
  `acces` VARCHAR(255) NOT NULL,
  `etat` VARCHAR(255) NOT NULL,
  `vu` INT NOT NULL,
  `genre` VARCHAR(255) NOT NULL,
  `lastPost` INT NULL,
  `firstPost` INT NOT NULL,
  `post` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sujet_Utilisateur1_idx` (`createur` ASC),
  INDEX `fk_sujet_forum1_idx` (`forum` ASC),
  CONSTRAINT `fk_sujet_Utilisateur1`
    FOREIGN KEY (`createur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sujet_forum1`
    FOREIGN KEY (`forum`)
    REFERENCES `Guess`.`Forum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Commentaire`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Commentaire` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Commentaire` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `dateCreation` DATETIME NOT NULL,
  `auteur` INT NOT NULL,
  `annonce` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_commentaire_Utilisateur1_idx` (`auteur` ASC),
  INDEX `fk_commentaire_anoonce1_idx` (`annonce` ASC),
  CONSTRAINT `fk_commentaire_Utilisateur1`
    FOREIGN KEY (`auteur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commentaire_anoonce1`
    FOREIGN KEY (`annonce`)
    REFERENCES `Guess`.`Annonce` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Role` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(255) NOT NULL,
  `categorie` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Post` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `topic` INT NOT NULL,
  `auteur` INT NOT NULL,
  `content` TEXT NOT NULL,
  `dateCreation` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_sujet1_idx` (`topic` ASC),
  INDEX `fk_post_Utilisateur1_idx` (`auteur` ASC),
  CONSTRAINT `fk_post_sujet1`
    FOREIGN KEY (`topic`)
    REFERENCES `Guess`.`Topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_Utilisateur1`
    FOREIGN KEY (`auteur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Message` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `objet` VARCHAR(255) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `expediteur` INT NOT NULL,
  `messagePrec` INT NULL,
  `type` VARCHAR(255) NOT NULL DEFAULT 'general',
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_Utilisateur1_idx` (`expediteur` ASC),
  INDEX `fk_Message_Message1_idx` (`messagePrec` ASC),
  CONSTRAINT `fk_message_Utilisateur1`
    FOREIGN KEY (`expediteur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Message_Message1`
    FOREIGN KEY (`messagePrec`)
    REFERENCES `Guess`.`Message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Badge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Badge` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Badge` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `intitule` VARCHAR(255) NOT NULL,
  `image` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Badge_Image1_idx` (`image` ASC),
  CONSTRAINT `fk_Badge_Image1`
    FOREIGN KEY (`image`)
    REFERENCES `Guess`.`Image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Curriculum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Curriculum` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Curriculum` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(255) NOT NULL,
  `header` TEXT NULL,
  `interest` VARCHAR(255) NULL,
  `proprietaire` INT NOT NULL,
  `disponibilite` TINYINT(1) NULL,
  `dateDebut` DATE NULL,
  `dateFin` DATE NULL,
  `fonction` VARCHAR(255) NULL,
  `prime` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_CV_Utilisateur1_idx` (`proprietaire` ASC),
  CONSTRAINT `fk_CV_Utilisateur1`
    FOREIGN KEY (`proprietaire`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Evenement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Evenement` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Evenement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `domaine` VARCHAR(255) NOT NULL,
  `header` VARCHAR(255) NOT NULL,
  `content` VARCHAR(255) NULL,
  `url` VARCHAR(255) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Label`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Label` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Label` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `intitule` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Competence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Competence` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Competence` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `domaine` VARCHAR(255) NOT NULL,
  `icone` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Competence_Image1_idx` (`icone` ASC),
  CONSTRAINT `fk_Competence_Image1`
    FOREIGN KEY (`icone`)
    REFERENCES `Guess`.`Image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Realisation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Realisation` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Realisation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  `descriptif` TEXT NOT NULL,
  `dateDebut` DATE NOT NULL,
  `dateFin` DATE NOT NULL,
  `utilisateur` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Realisation_Utilisateur1_idx` (`utilisateur` ASC),
  CONSTRAINT `fk_Realisation_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Etablissement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Etablissement` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Etablissement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Document`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Document` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Document` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `extension` VARCHAR(255) NOT NULL,
  `date` DATETIME NOT NULL,
  `proprietaire` INT NOT NULL,
  `docEnfant` INT NULL,
  `docParent` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_document_Utilisateur1_idx` (`proprietaire` ASC),
  INDEX `fk_document_enfant` (`docEnfant` ASC),
  INDEX `fk_Document_parent` (`docParent` ASC),
  CONSTRAINT `fk_document_Utilisateur1`
    FOREIGN KEY (`proprietaire`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_document_enfant`
    FOREIGN KEY (`docEnfant`)
    REFERENCES `Guess`.`Document` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Document_parent`
    FOREIGN KEY (`docParent`)
    REFERENCES `Guess`.`Document` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Filiere`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Filiere` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Filiere` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `niveau` VARCHAR(255) NOT NULL,
  `intitule` VARCHAR(255) NOT NULL,
  `domaine` VARCHAR(255) NOT NULL,
  `descriptif` TEXT NULL,
  `responsable` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Master_Utilisateur1_idx` (`responsable` ASC),
  CONSTRAINT `fk_Master_Utilisateur1`
    FOREIGN KEY (`responsable`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Participant_stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Participant_stage` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Participant_stage` (
  `stage` INT NOT NULL,
  `utilisateur` INT NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`stage`, `utilisateur`),
  INDEX `fk_stage_has_Utilisateur_Utilisateur1_idx` (`utilisateur` ASC),
  INDEX `fk_stage_has_Utilisateur_stage1_idx` (`stage` ASC),
  CONSTRAINT `fk_stage_has_Utilisateur_stage1`
    FOREIGN KEY (`stage`)
    REFERENCES `Guess`.`Stage` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stage_has_Utilisateur_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Detenteur_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Detenteur_role` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Detenteur_role` (
  `utilisateur` INT NOT NULL,
  `role` INT NOT NULL,
  PRIMARY KEY (`utilisateur`, `role`),
  INDEX `fk_Utilisateur_has_rôle_rôle1_idx` (`role` ASC),
  INDEX `fk_Utilisateur_has_rôle_Utilisateur1_idx` (`utilisateur` ASC),
  CONSTRAINT `fk_Utilisateur_has_rôle_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_has_rôle_rôle1`
    FOREIGN KEY (`role`)
    REFERENCES `Guess`.`Role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Notification` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Notification` (
  `evenement` INT NOT NULL,
  `utilisateur` INT NOT NULL,
  `vu` TINYINT(1) NOT NULL,
  PRIMARY KEY (`evenement`, `utilisateur`),
  INDEX `fk_evennement_has_Utilisateur_Utilisateur1_idx` (`utilisateur` ASC),
  INDEX `fk_evennement_has_Utilisateur_evennement1_idx` (`evenement` ASC),
  CONSTRAINT `fk_evennement_has_Utilisateur_evennement1`
    FOREIGN KEY (`evenement`)
    REFERENCES `Guess`.`Evenement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evennement_has_Utilisateur_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Competence_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Competence_user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Competence_user` (
  `competence` INT NOT NULL,
  `utilisateur` INT NOT NULL,
  `niveau` INT NOT NULL,
  PRIMARY KEY (`competence`, `utilisateur`),
  INDEX `fk_competence_has_Utilisateur_Utilisateur1_idx` (`utilisateur` ASC),
  INDEX `fk_competence_has_Utilisateur_competence1_idx` (`competence` ASC),
  CONSTRAINT `fk_competence_has_Utilisateur_competence1`
    FOREIGN KEY (`competence`)
    REFERENCES `Guess`.`Competence` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_competence_has_Utilisateur_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Labels_annonce`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Labels_annonce` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Labels_annonce` (
  `label` INT NOT NULL,
  `annonce` INT NOT NULL,
  PRIMARY KEY (`label`, `annonce`),
  INDEX `fk_Label_has_anoonce_anoonce1_idx` (`annonce` ASC),
  INDEX `fk_Label_has_anoonce_Label1_idx` (`label` ASC),
  CONSTRAINT `fk_Label_has_anoonce_Label1`
    FOREIGN KEY (`label`)
    REFERENCES `Guess`.`Label` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Label_has_anoonce_anoonce1`
    FOREIGN KEY (`annonce`)
    REFERENCES `Guess`.`Annonce` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Candidature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Candidature` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Candidature` (
  `etudiant` INT NOT NULL,
  `offre` INT NOT NULL,
  `message` TEXT NULL,
  `cv` INT NOT NULL,
  `etat` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`etudiant`, `offre`),
  INDEX `fk_Utilisateur_has_offre_offre1_idx` (`offre` ASC),
  INDEX `fk_Utilisateur_has_offre_Utilisateur1_idx` (`etudiant` ASC),
  INDEX `fk_Candidature_CV1_idx` (`cv` ASC),
  CONSTRAINT `fk_Utilisateur_has_offre_Utilisateur1`
    FOREIGN KEY (`etudiant`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_has_offre_offre1`
    FOREIGN KEY (`offre`)
    REFERENCES `Guess`.`Offre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Candidature_CV1`
    FOREIGN KEY (`cv`)
    REFERENCES `Guess`.`Curriculum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Detenteur_badge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Detenteur_badge` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Detenteur_badge` (
  `detenteur` INT NOT NULL,
  `badge` INT NOT NULL,
  `date` DATE NULL,
  `assignateur` INT NOT NULL,
  PRIMARY KEY (`detenteur`, `badge`),
  INDEX `fk_Utilisateur_has_badge_badge1_idx` (`badge` ASC),
  INDEX `fk_Utilisateur_has_badge_Utilisateur1_idx` (`detenteur` ASC),
  INDEX `fk_Detenteur_badge_Utilisateur1_idx` (`assignateur` ASC),
  CONSTRAINT `fk_Utilisateur_has_badge_Utilisateur1`
    FOREIGN KEY (`detenteur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_has_badge_badge1`
    FOREIGN KEY (`badge`)
    REFERENCES `Guess`.`Badge` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detenteur_badge_Utilisateur1`
    FOREIGN KEY (`assignateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Abonnement_sujet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Abonnement_sujet` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Abonnement_sujet` (
  `sujet` INT NOT NULL,
  `utilisateur` INT NOT NULL,
  PRIMARY KEY (`sujet`, `utilisateur`),
  INDEX `fk_sujet_has_Utilisateur_Utilisateur1_idx` (`utilisateur` ASC),
  INDEX `fk_sujet_has_Utilisateur_sujet1_idx` (`sujet` ASC),
  CONSTRAINT `fk_sujet_has_Utilisateur_sujet1`
    FOREIGN KEY (`sujet`)
    REFERENCES `Guess`.`Topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sujet_has_Utilisateur_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Validation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Validation` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Validation` (
  `offre` INT NOT NULL,
  `responsable` INT NOT NULL,
  `note` INT NOT NULL,
  `message` TEXT NULL,
  PRIMARY KEY (`offre`, `responsable`),
  INDEX `fk_Offre_has_Utilisateur_Utilisateur1_idx` (`responsable` ASC),
  INDEX `fk_Offre_has_Utilisateur_Offre1_idx` (`offre` ASC),
  CONSTRAINT `fk_Offre_has_Utilisateur_Offre1`
    FOREIGN KEY (`offre`)
    REFERENCES `Guess`.`Offre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Offre_has_Utilisateur_Utilisateur1`
    FOREIGN KEY (`responsable`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Suivre_filiere`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Suivre_filiere` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Suivre_filiere` (
  `filiere` INT NOT NULL,
  `etudiant` INT NOT NULL,
  `promotion` VARCHAR(255) NOT NULL,
  `session` INT NOT NULL,
  PRIMARY KEY (`filiere`, `etudiant`),
  INDEX `fk_Master_has_Utilisateur_Utilisateur1_idx` (`etudiant` ASC),
  INDEX `fk_Master_has_Utilisateur_Master1_idx` (`filiere` ASC),
  CONSTRAINT `fk_Master_has_Utilisateur_Master1`
    FOREIGN KEY (`filiere`)
    REFERENCES `Guess`.`Filiere` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Master_has_Utilisateur_Utilisateur1`
    FOREIGN KEY (`etudiant`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Parcours`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Parcours` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Parcours` (
  `utilisateur` INT NOT NULL,
  `etablissement` INT NOT NULL,
  `dateDebut` DATE NOT NULL,
  `dateFin` DATE NOT NULL,
  `diplome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`utilisateur`, `etablissement`),
  INDEX `fk_Utilisateur_has_etablissement_etablissement1_idx` (`etablissement` ASC),
  INDEX `fk_Utilisateur_has_etablissement_Utilisateur1_idx` (`utilisateur` ASC),
  CONSTRAINT `fk_Utilisateur_has_etablissement_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_has_etablissement_etablissement1`
    FOREIGN KEY (`etablissement`)
    REFERENCES `Guess`.`Etablissement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Parcours_cv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Parcours_cv` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Parcours_cv` (
  `cv` INT NOT NULL,
  `utilisateur` INT NOT NULL,
  `etablissement` INT NOT NULL,
  PRIMARY KEY (`cv`, `utilisateur`, `etablissement`),
  INDEX `fk_Curriculum_has_Parcours_Parcours1_idx` (`utilisateur` ASC, `etablissement` ASC),
  INDEX `fk_Curriculum_has_Parcours_Curriculum1_idx` (`cv` ASC),
  CONSTRAINT `fk_Curriculum_has_Parcours_Curriculum1`
    FOREIGN KEY (`cv`)
    REFERENCES `Guess`.`Curriculum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Curriculum_has_Parcours_Parcours1`
    FOREIGN KEY (`utilisateur` , `etablissement`)
    REFERENCES `Guess`.`Parcours` (`utilisateur` , `etablissement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Competence_cv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Competence_cv` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Competence_cv` (
  `cv` INT NOT NULL,
  `competence` INT NOT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`cv`, `competence`, `user`),
  INDEX `fk_Curriculum_has_Competence_user_Competence_user1_idx` (`competence` ASC, `user` ASC),
  INDEX `fk_Curriculum_has_Competence_user_Curriculum1_idx` (`cv` ASC),
  CONSTRAINT `fk_Curriculum_has_Competence_user_Curriculum1`
    FOREIGN KEY (`cv`)
    REFERENCES `Guess`.`Curriculum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Curriculum_has_Competence_user_Competence_user1`
    FOREIGN KEY (`competence` , `user`)
    REFERENCES `Guess`.`Competence_user` (`competence` , `utilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Realisation_cv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Realisation_cv` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Realisation_cv` (
  `cv` INT NOT NULL,
  `realisation` INT NOT NULL,
  PRIMARY KEY (`cv`, `realisation`),
  INDEX `fk_Curriculum_has_Realisation_Realisation1_idx` (`realisation` ASC),
  INDEX `fk_Curriculum_has_Realisation_Curriculum1_idx` (`cv` ASC),
  CONSTRAINT `fk_Curriculum_has_Realisation_Curriculum1`
    FOREIGN KEY (`cv`)
    REFERENCES `Guess`.`Curriculum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Curriculum_has_Realisation_Realisation1`
    FOREIGN KEY (`realisation`)
    REFERENCES `Guess`.`Realisation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Abonnement_annonce`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Abonnement_annonce` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Abonnement_annonce` (
  `utilisateur` INT NOT NULL,
  `annonce` INT NOT NULL,
  PRIMARY KEY (`utilisateur`, `annonce`),
  INDEX `fk_Utilisateur_has_Annonce_Annonce1_idx` (`annonce` ASC),
  INDEX `fk_Utilisateur_has_Annonce_Utilisateur1_idx` (`utilisateur` ASC),
  CONSTRAINT `fk_Utilisateur_has_Annonce_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_has_Annonce_Annonce1`
    FOREIGN KEY (`annonce`)
    REFERENCES `Guess`.`Annonce` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Reception`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Reception` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Reception` (
  `destinataire` INT NOT NULL,
  `message` INT NOT NULL,
  `vu` TINYINT(1) NOT NULL,
  PRIMARY KEY (`destinataire`, `message`),
  INDEX `fk_Utilisateur_has_Message_Message1_idx` (`message` ASC),
  INDEX `fk_Utilisateur_has_Message_Utilisateur1_idx` (`destinataire` ASC),
  CONSTRAINT `fk_Utilisateur_has_Message_Utilisateur1`
    FOREIGN KEY (`destinataire`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_has_Message_Message1`
    FOREIGN KEY (`message`)
    REFERENCES `Guess`.`Message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Personnel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Personnel` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Personnel` (
  `entreprise` INT NOT NULL,
  `utilisateur` INT NOT NULL,
  PRIMARY KEY (`entreprise`, `utilisateur`),
  INDEX `fk_Entreprise_has_Utilisateur_Utilisateur1_idx` (`utilisateur` ASC),
  INDEX `fk_Entreprise_has_Utilisateur_Entreprise1_idx` (`entreprise` ASC),
  CONSTRAINT `fk_Entreprise_has_Utilisateur_Entreprise1`
    FOREIGN KEY (`entreprise`)
    REFERENCES `Guess`.`Entreprise` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Entreprise_has_Utilisateur_Utilisateur1`
    FOREIGN KEY (`utilisateur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Rapport_stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Rapport_stage` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Rapport_stage` (
  `stage` INT NOT NULL,
  `document` INT NOT NULL,
  PRIMARY KEY (`stage`, `document`),
  INDEX `fk_Stage_has_Document_Document1_idx` (`document` ASC),
  INDEX `fk_Stage_has_Document_Stage1_idx` (`stage` ASC),
  CONSTRAINT `fk_Stage_has_Document_Stage1`
    FOREIGN KEY (`stage`)
    REFERENCES `Guess`.`Stage` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stage_has_Document_Document1`
    FOREIGN KEY (`document`)
    REFERENCES `Guess`.`Document` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Backlog_historique`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Backlog_historique` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Backlog_historique` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `descriptif` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  `auteur` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Backlog_historique_Utilisateur1_idx` (`auteur` ASC),
  CONSTRAINT `fk_Backlog_historique_Utilisateur1`
    FOREIGN KEY (`auteur`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Guess`.`Backlog_signalement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Guess`.`Backlog_signalement` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Guess`.`Backlog_signalement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(255) NULL,
  `url` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Backlog_signalement_Utilisateur1_idx` (`user` ASC),
  CONSTRAINT `fk_Backlog_signalement_Utilisateur1`
    FOREIGN KEY (`user`)
    REFERENCES `Guess`.`Utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

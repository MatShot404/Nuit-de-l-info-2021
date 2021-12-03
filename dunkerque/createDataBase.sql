/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 9.x                                */
/* Date de cr�ation :  03/12/2021 03:26:08                      */
/*==============================================================*/

drop table CANOT;
drop table EQUIPE;
drop table EST_SAUVEES;
drop table PARTICIPER;
drop table PERSONNES_SAUVEES;
drop table POSSEDER;
drop table POSTE;
drop table SAUVETAGE;
drop table SAUVETEUR;
drop table TITRE;

/*==============================================================*/
/* Table : CANOT                                                */
/*==============================================================*/
create table CANOT (
   IDCANNOT             SERIAL               not null,
   NOMCANNOT            VARCHAR(1024)        not null,
   constraint PK_CANOT primary key (IDCANNOT)
);

/*==============================================================*/
/* Table : SAUVETEUR                                            */
/*==============================================================*/
create table SAUVETEUR (
   IDSAUVETEUR          SERIAL               not null,
   NOMSAUVETEUR         VARCHAR(1024)        not null,
   PRENOMSAUVETEUR      VARCHAR(1024)        null,
   PRENOMSAUVETEUR2     VARCHAR(1024)        null,
   PRENOMSAUVETEUR3     VARCHAR(1024)        null,
   DATENAISSANCESAUVETEUR VARCHAR(10)          null,
   DATEDECESSAUVETEUR   VARCHAR(10)          null,
   constraint PK_SAUVETEUR primary key (IDSAUVETEUR)
);

/*==============================================================*/
/* Table : POSTE                                                */
/*==============================================================*/
create table POSTE (
   IDPOSTE              SERIAL               not null,
   LIBELLEPOSTE         VARCHAR(1024)        not null,
   constraint PK_POSTE primary key (IDPOSTE)
);

/*==============================================================*/
/* Table : SAUVETAGE                                            */
/*==============================================================*/
create table SAUVETAGE (
   IDSAUVETAGE          SERIAL               not null,
   TITRESAUVETAGE       VARCHAR(1024)        not null,
   DATESAUVETAGE        VARCHAR(10)          not null,
   DESCRITPIFSAUVETAGE  VARCHAR(1024)        null,
   constraint PK_SAUVETAGE primary key (IDSAUVETAGE)
);

/*==============================================================*/
/* Table : PARTICIPER                                           */
/*==============================================================*/
create table PARTICIPER (
   IDSAUVETAGE          INT4                 not null,
   IDCANNOT             INT4                 not null,
   constraint PK_PARTICIPER primary key (IDSAUVETAGE, IDCANNOT),
   constraint FK_PARTICIP_PARTICIPE_SAUVETAG foreign key (IDSAUVETAGE)
      references SAUVETAGE (IDSAUVETAGE)
      on delete restrict on update restrict,
   constraint FK_PARTICIP_PARTICIPE_CANOT foreign key (IDCANNOT)
      references CANOT (IDCANNOT)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Table : EQUIPE                                               */
/*==============================================================*/
create table EQUIPE (
   IDPERSONNE           INT4                 not null,
   IDMETIER             INT4                 not null,
   IDSAUVETAGE          INT4                 not null,
   IDCANNOT             INT4                 null,
   constraint PK_EQUIPE primary key (IDPERSONNE, IDMETIER, IDSAUVETAGE),
   constraint FK_EQUIPE_COMPOSER_SAUVETEU foreign key (IDPERSONNE)
      references SAUVETEUR (IDSAUVETEUR)
      on delete restrict on update restrict,
   constraint FK_EQUIPE_COMPOSER3_POSTE foreign key (IDMETIER)
      references POSTE (IDPOSTE)
      on delete restrict on update restrict,
   constraint FK_EQUIPE_REFERENCE_PARTICIP foreign key (IDSAUVETAGE, IDCANNOT)
      references PARTICIPER (IDSAUVETAGE, IDCANNOT)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Table : PERSONNES_SAUVEES                                    */
/*==============================================================*/
create table PERSONNES_SAUVEES (
   IDPSAUVEE            SERIAL               not null,
   NOMPSAUVEE           VARCHAR(1024)        not null,
   PRENOMPSAUVEE        VARCHAR(1024)        null,
   PRENOMPSAUVEE2       VARCHAR(1024)        null,
   PRENOMPSAUVEE3       VARCHAR(1024)        null,
   DATENAISSANCEPSAUVEE VARCHAR(1024)        null,
   DATEDECESPSAUVEE     VARCHAR(1024)        null,
   constraint PK_PERSONNES_SAUVEES primary key (IDPSAUVEE)
);

/*==============================================================*/
/* Table : EST_SAUVEES                                          */
/*==============================================================*/
create table EST_SAUVEES (
   IDPERSONNE           INT4                 not null,
   IDSAUVETAGE          INT4                 not null,
   DATESAUVETAGE        VARCHAR(10)          not null,
   constraint PK_EST_SAUVEES primary key (IDPERSONNE, IDSAUVETAGE, DATESAUVETAGE),
   constraint FK_EST_SAUV_EST_SAUVE_PERSONNE foreign key (IDPERSONNE)
      references PERSONNES_SAUVEES (IDPSAUVEE)
      on delete restrict on update restrict,
   constraint FK_EST_SAUV_EST_SAUVE_SAUVETAG foreign key (IDSAUVETAGE)
      references SAUVETAGE (IDSAUVETAGE)
      on delete restrict on update restrict
);

/*==============================================================*/
/* Table : TITRE                                                */
/*==============================================================*/
create table TITRE (
   IDTITRE              SERIAL               not null,
   LIBELLETITRE         VARCHAR(1024)        not null,
   constraint PK_TITRE primary key (IDTITRE)
);

/*==============================================================*/
/* Table : POSSEDER                                             */
/*==============================================================*/
create table POSSEDER (
   IDTITRE              INT4                 not null,
   IDPERSONNE           INT4                 not null,
   NOMSAUVETEUR         VARCHAR(1024)        not null,
   constraint PK_POSSEDER primary key (IDTITRE, IDPERSONNE, NOMSAUVETEUR),
   constraint FK_POSSEDER_POSSEDER_TITRE foreign key (IDTITRE)
      references TITRE (IDTITRE)
      on delete restrict on update restrict,
   constraint FK_POSSEDER_POSSEDER2_SAUVETEU foreign key (IDPERSONNE)
      references SAUVETEUR (IDSAUVETEUR)
      on delete restrict on update restrict
);


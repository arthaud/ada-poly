------------------------------------------
-- Paquetage arbre naire de caracteres
------------------------------------------
package p_arbren is

  type arbren is private;

  ARBRE_VIDE : exception;
  PERE_ABSENT : exception;
  FILS_ABSENT : exception;
  FRERE_ABSENT : exception;

  ------------------
  -- 1 - CREATION --
  ------------------

  -- Fonction An_Creer_Vide
  -- Sémantique : Créer un arbre n-aire vide
  -- Paramètres : /
  -- Type retour : arbren
  -- Précondition : /
  -- Postcondition : Un arbren (vide) existe
  -- Exception : /
  function An_Creer_Vide return arbren;

  -- Fonction An_Creer_Feuille
  -- Sémantique : Créer un arbre n-aire avec une valeur mais sans fils, ni frère, ni père
  -- Paramètres : nouveau : character (D)
  -- Type retour : arbren
  -- Précondition : /
  -- Postcondition : Un arbre avec uniquement une seule valeur existe
  -- Exception : /
  function An_Creer_Feuille(nouveau : in character) return arbren;

  ----------------------
  -- 2 - Consultation --
  ----------------------

  -- Fonction An_Vide
  -- Sémantique : Détecter si un arbren est vide ou non
  -- Paramètres : a : arbren (D)
  -- Type retour : booléen (vaut vrai si l'arbre est vide)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : /
  function An_Vide(a : in arbren) return boolean;

  -- Fonction An_Valeur
  -- Sémantique : Retourne la valeur rangée à la racine d'un arbre
  -- Paramètres : a : arbren (D)
  -- Type retour : character
  -- Précondition : /
  -- Postcondition : La valeur à la racine est retournée
  -- Exception : ARBRE_VIDE
  function An_Valeur(a : in arbren) return character;

  -- Fonction An_Pere
  -- Sémantique : Retourne l'arbre père d'un arbre
  -- Paramètres : a : arbren (D)
  -- Type retour : arbren
  -- Précondition : /
  -- Postcondition : Le père de a est retourné
  -- Exception : ARBRE_VIDE, PERE_ABSENT
  function An_Pere(a : in arbren) return arbren;

  -- Procédure An_Afficher
  -- Sémantique : Afficher le contenu complet d'un arbre
  -- Paramètres : a : arbren (D)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  procedure An_Afficher(a : in arbren);

  -- Fonction An_Rechercher
  -- Sémantique : Recherche une valeur dans un arbre et retourne l'arbre dont la valeur est racine si elle est trouvée, un arbre vide sinon
  -- Paramètres : a : arbren (D)
  --              data : character (D)
  -- Type retour : arbren
  -- Précondition : /
  -- Postcondition : Un arbre est retourné (vide éventuellement)
  -- Exception : /
  function An_Rechercher(a : in arbren; data : in character) return arbren;

  -- Fonction An_Est_Feuille
  -- Sémantique : Indiquer si un arbre est une feuille (pas de fils)
  -- Paramètres : a : arbren (D)
  -- Type retour : booléen (vaut vrai si l'arbre n'a pas de fils)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function An_Est_Feuille(a : in arbren) return boolean;

  -- Fonction An_Est_Racine
  -- Sémantique : Indiquer si un arbre est sans père
  -- Paramètres : a : arbren (D)
  -- Type retour : booléen (vaut vrai si l'arbre n'a pas de père)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function An_Est_Racine(a : in arbren) return boolean;

  ----------------------
  -- 3 - MODIFICATION --
  ----------------------

  -- Procédure An_Changer_Valeur
  -- Sémantique : Changer la valeur rangée à la racine d'un arbre
  -- Paramètres : a : arbren (D/R)
  --              nouveau : character (D)
  -- Précondition : /
  -- Postcondition : La racine de l'arbre est modifiée
  -- Exception : ARBRE_VIDE
  procedure An_Changer_Valeur(a : in out arbren; nouveau : in character);

  -- Procédure An_Inserer_Fils
  -- Sémantique : Insérer un arbre sans frère en position de premier fils d'un arbre a. L'ancien fils de a devient alors le premier frère de l'arbre inséré.
  -- Paramètres : a : arbren (D/R)
  --              a_ins : arbren (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de premier fils de a
  -- Exception : ARBRE_VIDE
  procedure An_Inserer_Fils(a : in out arbren; a_ins: in out arbren);

  -- Procédure An_Inserer_Frere
  -- Sémantique : Insérer un arbre sans frère en position de premier frère d'un arbre a
  -- Paramètres : a : arbren (D/R)
  --              a_ins : arbren (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de premier frère de a
  -- Exception : ARBRE_VIDE
  procedure An_Inserer_Frere(a : in out arbren; a_ins : in out arbren);

  -- Procédure An_Supprimer_Fils
  -- Sémantique : Supprimer le nième fils d'un arbre
  -- Paramètres : a : arbren (D/R)
  --              n : integer (D)
  -- Précondition : n >= 1
  -- Postcondition : Le nième fils est supprimé. Les fils n+i+1 deviennent les fils n+i (i>=0).
  -- Exception : ARBRE_VIDE, FILS_ABSENT
  procedure An_Supprimer_Fils(a : in out arbren; n : in integer);

  -- Procédure An_Supprimer_Frere
  -- Sémantique : Supprimer le nième frère d'un arbre
  -- Paramètres : a : arbren (D/R)
  --              n : integer (D)
  -- Précondition : n >= 1
  -- Postcondition : Le nième frère est supprimé. Les frères n+i+1 deviennent les frères n+i (i>=0).
  -- Exception : ARBRE_VIDE, FRERE_ABSENT
  procedure An_Supprimer_Frere(a : in out arbren; n : in integer);

  private
    type noeud;
    type arbren is access noeud;
    type noeud is record
      valeur : character;
      fils : arbren;
      pere : arbren;
      frere : arbren;
    end record;
end p_arbren;

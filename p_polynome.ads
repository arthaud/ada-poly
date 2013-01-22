with p_arbre_poly; use p_arbre_poly;

------------------------
-- Paquetage polynôme
------------------------
package p_polynome is

  type polynome is private;

  CMAX : constant integer := 100;
  
  type str is record
    valeur : string(1..CMAX);
    longueur : integer;
  end record;

  LONGUEUR_MAX : exception;

  ------------------------------------------
  -- Fonction de Manipulation du type str --
  ------------------------------------------
  
  -- Procedure Lire_Entier
  -- Sémantique : Lire un entier à partir de la position pos
  -- Paramètres : p : str (D)
  --              pos : integer (D/R)
  --              entier : integer (R)
  -- Précondition : /
  -- Postcondition : /
  procedure Lire_Entier(p : in str; pos : in out integer; entier : out integer);
  
  -- procedure Ecrire_Caractere
  -- Sémantique : Ecrit un caractère dans le résultat
  -- Paramètres : resultat : str (D/R)
  --              c : character (D)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : LONGUEUR_MAX
  procedure Ecrire_Caractere(resultat : in out str; c : in character);
  
  -- procedure Ecrire_Entier
  -- Sémantique : Ecrit un entier dans le résultat
  -- Paramètres : resultat : str (D/R)
  --              n : integer (D)
  -- Précondition : n >= 0
  -- Postcondition : /
  -- Exception : LONGUEUR_MAX
  procedure Ecrire_Entier(resultat : in out str; n : in integer);
 
  --------------------------------------------
  -- Fonction de Manipulation des polynomes --
  --------------------------------------------

  -- Fonction Encoder
  -- Sémantique : Prend un polynôme sous forme de chaine de caractères, et retourne un polynôme
  -- Paramètres : p : str (D)
  -- Type retour : polynome
  -- Précondition : p vérifie les contraintes du sujet
  -- Postcondition : le polynôme retourné est p
  function Encoder(p : in str) return polynome;

  -- Fonction Decoder
  -- Sémantique : Prend un polynôme et retourne la chaine de caractères correspondante
  -- Paramètres : p : polynome (D)
  -- Type retour : str
  -- Précondition : /
  -- Postcondition : la chaine de caractère vérifie les contraintes du sujet
  -- Exception : LONGUEUR_MAX
  function Decoder(p : in polynome) return str;

  -- Fonction Ajouter
  -- Sémantique : Fait l'addition de deux polynomes
  -- Paramètres : p1 : polynome (D)
  --              p2 : polynome (D)
  -- Type retour : polynome
  -- Précondition : /
  -- Postcondition : la sortie vaut p1 + p2
  function Ajouter(p1 : in polynome; p2 : in polynome) return polynome;

  private
    type polynome is new arbre_poly;
    -- Invariants respectés par le type polynome :
    -- * polynome est la racine d'un arbre naire, donc sans frère
    -- * les fils sont rangés dans l'ordre : de la plus petite puissance à la plus grande
    -- * pour un noeud, 
    --    Si const = 0, var /= ' ' et le noeud a au moins un fils
    --    Sinon const /= 0, var = ' ' et le noeud n'a aucun fils

end p_polynome;

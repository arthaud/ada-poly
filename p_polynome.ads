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

  -- Fonction Encoder
  -- Sémantique : Prend un polynôme sous forme de chaine de caractères, et retourne un polynôme
  -- Paramètres : p : str (D)
  -- Type retour : polynome
  -- Précondition : p vérifie les contraintes du sujet
  -- Postcondition : le polynôme retourné est p
  -- function Encoder(p : in str) return polynome;

  -- Fonction Decoder
  -- Sémantique : Prend un polynôme et retourne la chaine de caractères correspondante
  -- Paramètres : p : polynome (D)
  -- Type retour : str
  -- Précondition : /
  -- Postcondition : la chaine de caractère vérifie les contraintes du sujet
  -- Exception : LONGUEUR_MAX
  function Decoder(p : in arbre_poly) return str;

  -- Fonction Ajouter
  -- Sémantique : Fait l'addition de deux polynomes
  -- Paramètres : p1 : polynome (D)
  --              p2 : polynome (D)
  -- Type retour : polynome
  -- Précondition : /
  -- Postcondition : la sortie vaut p1 + p2
  function Ajouter(p1 : in arbre_poly; p2 : in arbre_poly) return arbre_poly;

  private
    type polynome is new arbre_poly;
    -- Invariants respectés par le type polynome :
    -- * polynome est la racine d'un arbre naire, donc sans frère
    -- * les fils sont rangés dans l'ordre : de la plus petite puissance à la plus grande
    -- * pour un noeud, 
    --    Si const = 0, var /= ' ' et le noeud a au moins un fils
    --    Sinon const /= 0, var = ' ' et le noeud n'a aucun fils

end p_polynome;

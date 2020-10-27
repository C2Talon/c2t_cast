# c2t_burn

Kolmafia script to burn all health on a blood spell or burn all charges of the Powerful Glove on a cheat code.

`svn checkout https://github.com/c2talon/c2t_burn/branches/main/kolmafia/`

## Usage

### CLI

Can be used with the CLI via:
`c2t_burn <bubble | bond | frenzy | triple | invisible | invis>`
* `bubble` will burn health by max-casting Blood Bubble
* `bond` will burn health by max-casting Blood Bond
* `frenzy` will burn health by max-casting Blood Frenzy
* `triple` will burn Powerful Glove charges by max-casting Triple Size
* `invisible` or `invis` will burn Powerful Glove charges by max-casting Invisible Avatar

### Functions

Functions within can be called via another script when `import`ed.

`c2t_bloodBurn(skill spell)`:
This is for max-casting one of Blood Bubble, Blood Bond, or Blood Frenzy, where `spell` is the skill to use. Ex: `c2t_bloodBurn($skill[Blood Bubble]);`

`c2t_tripleBurn(skill spell)`:
This is for max-casting one of CHEAT CODE: Triple Size or CHEAT CODE: Invisible Avatar, where `spell` is the skill to use. Ex: `c2t_tripleBurn($skill[CHEAT CODE: Triple Size]);`

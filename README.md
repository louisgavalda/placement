# Scripts pour Adobe Illustrator

## Installation

### Depuis le terminal
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/louisgavalda/placement/refs/heads/main/install.sh)"
```

### Pour créer une application
```
tell application "Terminal"
	activate
	do script "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/louisgavalda/placement/refs/heads/main/install.sh)\""
end tell
```
cf. [Enregistrer un script en tant qu’app dans Éditeur de script sur Mac](https://support.apple.com/fr-fr/guide/script-editor/scpedt1072/2.11/mac/15.0)

### Installation manuelle
Copier le contenu du dossier `scripts/` dans le(s) dossier(s) suivant(s) :
- `/Applications/Adobe Illustrator 2025/Presets.localized/fr_FR/Scripts`

## Notes

### Désactivation de...

Vous pouvez [masquer la fenêtre d'alerte](https://helpx.adobe.com/illustrator/using/automation-scripts.html) lorsque vous...
### JS/JSX
Illustrator exécute de la même manière les scripts au format JS ou JSX.

## Ressources

`/Library/Application Support/Adobe/Startup Scripts CC/Illustrator 2025`

https://aiscripts.medium.com/how-to-write-scripts-for-adobe-illustrator-263dbd515baa

https://scriptui.joonas.me
https://github.com/rjduran/adobe-scripting
https://helpx.adobe.com/fr/photoshop/using/scripting.html
https://github.com/lohriialo/illustrator-scripting-python
https://github.com/AngeloD2022/jsxer
https://enseignement.leomartin.net/ucp/2019-2020/lptsi/programmation-javascript-appliquee-a-after-effects/ressources/installer-extendscript-toolkit-cc/index.html
https://marketplace.visualstudio.com/items?itemName=Adobe.extendscript-debug#known-issues
https://github.com/Adobe-CEP/CEP-Resources/tree/master/ExtendScript-Toolkit
https://ai-scripting.docsforadobe.dev/introduction/executingScripts.html
https://github.com/docsforadobe/illustrator-scripting-guide?tab=readme-ov-file
https://images.autodesk.com/adsk/files/autocad_2012_pdf_dxf-reference_enu.pdf
 
https://www.youtube.com/watch?v=KPSS3Arezx4
https://creativecloud.adobe.com/fr/discover/video/Crash-Course-Automating-Photoshop-Part-2-with-Tim-Moebest/20821

https://support.apple.com/fr-fr/guide/automator/welcome/mac
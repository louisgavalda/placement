enum Genre {
  HOMME = "HOMME",
  FEMME = "FEMME",
  UNI = "UNI",
}

enum CodeDossier {
  LIV = "LIV",
  REF = "REF",
  TRA = "TRA",
}

type DirectoryStructure = {
    trimestre: string | null;
    genre: Genre | null;
    collection: string | null;
    animation: string | null;
    code_dossier: CodeDossier | null;
    segment: string | null;
    produit: string | null;
};

type FilenameStructure = {
    trimestre: string | null;
    collection: string | null;
    animation: string | null;
    produit: string | null;
    version: int | null;
    date: string | null;
};

function parseDirectoryPath(path: string): DirectoryStructure {
  // Les noms de dossiers sont séparés par le caractère `/` ; on gère le cas où plusieurs `/` se suivent (exemple : `/home//user///`).
  const directories = path.split('/').filter(Boolean);

  const structure: DirectoryStructure = {
    trimestre: null,
    genre: null,
    collection: null,
    animation: null,
    code_dossier: null,
    segment: null,
    produit: null,
  };

  // Chaîne vide.
  if (!path) {
    return structure;
  }

  let i = 0;
  // On trouve l'index du premier dossier dont le nom ressemble à un trimestre (exemple : `24-Q1`).
  while (i < directories.length && !/^\d{2}-Q\d$/.test(directories[i])) {
    i++;
  }
  // Le premier dossier est nommé suivant le trimestre.
  structure.trimestre = directories[i];
  // Le suivant est le genre.
  structure.genre = Genre[directories[i + 1] as keyof typeof Genre];
  // Si le deuxième prochain dossier est un dossier de travail (exemples : `TRA`, `LIV`), alors on sait que le prochain
  // dossier portera le nom de l'animation. Sinon on sait que le prochain dossier portera le nom de la collection.
  // @ts-ignore
  if (Object.values(CodeDossier).includes(directories[i + 3])) {
    structure.animation = directories[i + 2];
    structure.code_dossier = CodeDossier[directories[i + 3] as keyof typeof CodeDossier];
    structure.segment = directories[i + 4];
  } else {
    structure.collection = directories[i + 2];
    structure.animation = directories[i + 3];
    structure.code_dossier = CodeDossier[directories[i + 4] as keyof typeof CodeDossier];
    structure.segment = directories[i + 5];
  }

  return structure;
}

function parseFilePath(filename: string): FilenameStructure {
  const structure: FilenameStructure = {
    trimestre: null,
    collection: null,
    animation: null,
    produit: null,
    version: null,
    date: null,
  };

  const [basename, ext] = extractBasenameAndExtension(filename);
  const parts = basename.split('-');
  parts.reverse();
  console.log(parts);

  // La première partie est la date de création du fichier.
  structure.date = parts[0];
  // La deuxième partie est la version du fichier.
  structure.version = parts[1];
  // La dernière partie est le trimestre.
  structure.trimestre = parts[parts.length - 1] + '-' + parts[parts.length - 2];

  return structure;
}

/**
 * Extracts and returns the file name from a given full path.
 *
 * @param {string} fullPath - The full path from which the file name should be extracted.
 * @return {string} The extracted file name.
 *
 * @example
 * ```typescript
 * const path = "/home/user/documents/file.txt";
 * const fileName = getFileNameFromPath(path);
 * console.log(fileName); // Output: file.txt
 * ```
 */
function getFileNameFromPath(fullPath: string): string {
  const parts = fullPath.split('/');
  return parts[parts.length - 1];
}


/**
 * Extracts the basename and the extension from a given filename.
 *
 * @param {string} filename - The filename from which to extract the basename and extension.
 * @return {[string, string]} A tuple containing the basename and the extension.
 *
 * @example
 * ```typescript
 * const name = "file.txt";
 * const result = extractBasenameAndExtension(name);
 * console.log(result); // Output: ["file", "txt"]
 * ```
 */
function extractBasenameAndExtension(filename: string): [string, string] {
  const dotIndex = filename.lastIndexOf('.');
  if (dotIndex === -1) {
    return [filename, ""];  // No extension found
  }
  const basename = filename.substring(0, dotIndex);
  const extension = filename.substring(dotIndex + 1);
  return [basename, extension];
}

let test_path = "/Volumes/Public/TRANSFORMATIONS/24-Q4/HOMME/MNG-TRANSPARENT/TRA/TRAVEL/24-Q4-MNG-TRANSPARENT-POCHETTE-TRIO-(03)-240108.ai";
let s1 = parseDirectoryPath(test_path);
console.log(s1);
let filename = getFileNameFromPath(test_path);
console.log(filename);
let basename = extractBasenameAndExtension(filename);
console.log(basename);
let s2 = parseFilePath(filename);
console.log(s2);

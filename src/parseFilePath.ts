function parseFilePath(path: string) {
  // Découpe le chemin en segments
  const segments = path.split('/').filter(Boolean);

  // Extrait le nom du fichier (dernier élément)
  const fileName = segments.pop();

  // Analyse chaque dossier
  const folders = segments.map((folder, index) => {
    return {
      level: index + 1,
      name: folder,
      fullPath: '/' + segments.slice(0, index + 1).join('/')
    };
  });
  return folders;
}
var path = "/Volumes/Public/TRANSFORMATIONS/24-Q4/HOMME/MNG-TRANSPARENT/TRA/TRAVEL/24-Q4-MNG-TRANSPARENT-POCHETTE-TRIO-(03)-240108.ai";
var r = parseFilePath(path);
console.log(r);
// alert(r);
{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    zotero
    jre
    discord
    zathura
    foliate
    xournalpp
  ];
}

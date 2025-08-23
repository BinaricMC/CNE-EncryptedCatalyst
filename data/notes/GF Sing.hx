function onNoteHit(e) {
    if (e.noteType == "GF Sing") e.characters = strumLines.members[2].characters;
}

function onPlayerMiss(e) {
    if (e.noteType == "GF Sing") e.characters = strumLines.members[2].characters;
}
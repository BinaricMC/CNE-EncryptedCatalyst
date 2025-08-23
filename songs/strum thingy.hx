function postCreate() {
    for (mem in strumLines.members[1].members) {
        mem.animation.onFinish.add(function(name:String) {
            if (StringTools.contains(name, 'confirm')) {
                mem.playAnim('pressed');
            }
        });
    }
}
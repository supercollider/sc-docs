var exportDir = "SC_DOCS_BUILD_DIR".getenv ? "/root/scdocs";

SCDoc.helpTargetDir_(exportDir);

SCDoc.renderAll;

"%".format("*".dup(50).join).postln;

"Exported docs to %".format(SCDoc.helpTargetDir).postln;

0.exit;

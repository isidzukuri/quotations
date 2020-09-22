copyInputGroup = function(node) {
  var input_group = node.previousSibling.cloneNode(true);
  var elements = input_group.getElementsByTagName("input");
  for (var i=0; i < elements.length; i++) {
    if (elements[i].type == "text") {
      elements[i].value = "";
    }
  }

  node.parentNode.insertBefore(input_group, node);
}
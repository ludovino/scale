extends Node
class_name NodeExtensions
static func get_descendents(node, array = []):
	array.append(node)
	for child in node.get_children():
		get_descendents(child, array)
	return array

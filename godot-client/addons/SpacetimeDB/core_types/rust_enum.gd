class_name RustEnum extends Resource

@export var value: int = 0
@export var data: Variant = null

@export var data_reference: Resource:
	set(new_value):
		data_reference = new_value
		if data_reference != null:
			var resolved_id: int = _resolve_id_from_resource(data_reference)
			if resolved_id >= 0:
				data = resolved_id
		emit_changed()


func _resolve_id_from_resource(resource: Resource) -> int:
	if resource == null:
		return -1

	if resource.has_method("get_id"):
		var resolved: Variant = resource.call("get_id")
		if typeof(resolved) == TYPE_INT:
			return resolved

	if "id" in resource:
		var resource_id: Variant = resource.get("id")
		if typeof(resource_id) == TYPE_INT:
			return resource_id

	if "generic_data" in resource:
		var generic_data: Variant = resource.get("generic_data")
		if generic_data != null:
			if "id" in generic_data:
				var generic_id: Variant = generic_data.get("id")
				if typeof(generic_id) == TYPE_INT:
					return generic_id
			if "entity_type_id" in generic_data:
				var entity_type_id: Variant = generic_data.get("entity_type_id")
				if typeof(entity_type_id) == TYPE_INT:
					return entity_type_id

	return -1


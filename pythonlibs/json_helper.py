import json
import jsonpointer
import jsonpatch


def load_json(json_string):
    try:
        return json.loads(json_string)
    except ValueError as e:
        raise ValueError("Could not parse '%s' as JSON: %s" % (json_string, e))


def get_json_value(json_string, json_pointer):
    json_string = load_json(json_string)
    return jsonpointer.resolve_pointer(json_string, json_pointer)


def set_json_value(json_string, json_pointer, json_value):
    if type(json_string) != str:
        json_string = stringify_json(json_string)
    json_string = load_json(json_string)
    json_string = jsonpatch.apply_patch(json_string, [{
                                               'op': 'add',
                                               'path': json_pointer,
                                               'value': load_json(json_value)
                                               }])
    return stringify_json(json_string)


def stringify_json(data):
    try:
        return json.dumps(data, ensure_ascii=False)
    except ValueError as e:
        raise ValueError(
            "Could not stringify '%r' to JSON: %s" % (data, e))


def parse_json(json_string):
    if type(json_string) != str:
        json_string = stringify_json(json_string)
    return load_json(json_string)


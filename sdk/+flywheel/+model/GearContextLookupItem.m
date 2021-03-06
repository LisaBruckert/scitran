% GearContextLookupItem
%
% GearContextLookupItem Properties:
%    found          - Was the context value found?
%    containerType  - The type of container (e.g. session)
%    id             - Id of the container where the context value was found, if any.
%    label          - Label of the container where the context value was found, if any.
%    value          - The value if found. Valid IFF found is true. Can be null.
%
% GearContextLookupItem Methods:
%    toJson - Convert the object to a Map that can be encoded to json
%    struct - Convert the object to a struct
    classdef GearContextLookupItem < flywheel.ModelBase
    % NOTE: This file is auto generated by the swagger code generator program.
    % Do not edit the file manually.
    properties (Constant)
        propertyMap = containers.Map({ 'found', 'containerType', 'id', 'label', 'value' }, ...
            { 'found', 'container_type', 'id', 'label', 'value' });
    end
    properties(Dependent)
        found
        containerType
        id
        label
        value
    end
    methods
        function obj = GearContextLookupItem(varargin)
            obj@flywheel.ModelBase(flywheel.model.GearContextLookupItem.propertyMap);

            % Allow empty object creation
            if length(varargin)
                p = inputParser;
                addParameter(p, 'found', []);
                addParameter(p, 'containerType', []);
                addParameter(p, 'id', []);
                addParameter(p, 'label', []);
                addParameter(p, 'value', []);

                parse(p, varargin{:});

                if ~isempty(p.Results.found)
                    obj.props_('found') = p.Results.found;
                end
                if ~isempty(p.Results.containerType)
                    obj.props_('container_type') = p.Results.containerType;
                end
                if ~isempty(p.Results.id)
                    obj.props_('id') = p.Results.id;
                end
                if ~isempty(p.Results.label)
                    obj.props_('label') = p.Results.label;
                end
                if ~isempty(p.Results.value)
                    obj.props_('value') = p.Results.value;
                end
            end
        end
        function result = get.found(obj)
            if ismethod(obj, 'get_found')
                result = obj.get_found();
            else
                if isKey(obj.props_, 'found')
                    result = obj.props_('found');
                else
                    result = [];
                end
            end
        end
        function obj = set.found(obj, value)
            obj.props_('found') = value;
        end
        function result = get.containerType(obj)
            if ismethod(obj, 'get_containerType')
                result = obj.get_containerType();
            else
                if isKey(obj.props_, 'container_type')
                    result = obj.props_('container_type');
                else
                    result = [];
                end
            end
        end
        function obj = set.containerType(obj, value)
            obj.props_('container_type') = value;
        end
        function result = get.id(obj)
            if ismethod(obj, 'get_id')
                result = obj.get_id();
            else
                if isKey(obj.props_, 'id')
                    result = obj.props_('id');
                else
                    result = [];
                end
            end
        end
        function obj = set.id(obj, value)
            obj.props_('id') = value;
        end
        function result = get.label(obj)
            if ismethod(obj, 'get_label')
                result = obj.get_label();
            else
                if isKey(obj.props_, 'label')
                    result = obj.props_('label');
                else
                    result = [];
                end
            end
        end
        function obj = set.label(obj, value)
            obj.props_('label') = value;
        end
        function result = get.value(obj)
            if ismethod(obj, 'get_value')
                result = obj.get_value();
            else
                if isKey(obj.props_, 'value')
                    result = obj.props_('value');
                else
                    result = [];
                end
            end
        end
        function obj = set.value(obj, value)
            obj.props_('value') = value;
        end
        function result = toJson(obj)
            result = containers.Map;
            if isKey(obj.props_, 'found')
                result('found') = flywheel.ModelBase.serializeValue(obj.props_('found'), 'logical');
            end
            if isKey(obj.props_, 'container_type')
                result('container_type') = flywheel.ModelBase.serializeValue(obj.props_('container_type'), 'char');
            end
            if isKey(obj.props_, 'id')
                result('id') = flywheel.ModelBase.serializeValue(obj.props_('id'), 'char');
            end
            if isKey(obj.props_, 'label')
                result('label') = flywheel.ModelBase.serializeValue(obj.props_('label'), 'char');
            end
            if isKey(obj.props_, 'value')
                result('value') = flywheel.ModelBase.serializeValue(obj.props_('value'), 'containers.Map');
            end
        end
        function result = struct(obj)
            result = struct;

            if isKey(obj.props_, 'found')
                result.found = obj.props_('found');
            else
                result.found = [];
            end
            if isKey(obj.props_, 'container_type')
                result.containerType = obj.props_('container_type');
            else
                result.containerType = [];
            end
            if isKey(obj.props_, 'id')
                result.id = obj.props_('id');
            else
                result.id = [];
            end
            if isKey(obj.props_, 'label')
                result.label = obj.props_('label');
            else
                result.label = [];
            end
            if isKey(obj.props_, 'value')
                result.value = obj.props_('value');
            else
                result.value = [];
            end
        end
        function result = returnValue(obj)
            result = obj;
        end
    end
    methods(Access = protected)
        function prpgrp = getPropertyGroups(obj)
            if ~isscalar(obj)
                prpgrp = getPropertyGroups@matlab.mixin.CustomDisplay(obj);
            else
                propList = struct;
                if isKey(obj.props_, 'found')
                    propList.found = obj.props_('found');
                else
                    propList.found = [];
                end
                if isKey(obj.props_, 'container_type')
                    propList.containerType = obj.props_('container_type');
                else
                    propList.containerType = [];
                end
                if isKey(obj.props_, 'id')
                    propList.id = obj.props_('id');
                else
                    propList.id = [];
                end
                if isKey(obj.props_, 'label')
                    propList.label = obj.props_('label');
                else
                    propList.label = [];
                end
                if isKey(obj.props_, 'value')
                    propList.value = obj.props_('value');
                else
                    propList.value = [];
                end
                prpgrp = matlab.mixin.util.PropertyGroup(propList);
            end
        end
    end
    methods(Static)
        function obj = fromJson(json, context)
            obj =  flywheel.model.GearContextLookupItem;
            if isfield(json, 'found')
                obj.props_('found') = flywheel.ModelBase.deserializeValue(json.found, 'logical');
            end
            if isfield(json, 'container_type')
                obj.props_('container_type') = flywheel.ModelBase.deserializeValue(json.container_type, 'char');
            end
            if isfield(json, 'id')
                obj.props_('id') = flywheel.ModelBase.deserializeValue(json.id, 'char');
            end
            if isfield(json, 'label')
                obj.props_('label') = flywheel.ModelBase.deserializeValue(json.label, 'char');
            end
            if isfield(json, 'value')
                obj.props_('value') = flywheel.ModelBase.deserializeValue(json.value, 'containers.Map');
            end
            if isprop(obj, 'context_')
                obj.setContext_(context);
            end
        end
        function obj = ensureIsInstance(obj)
            if ~isempty(obj)
                % Realistically, we only convert structs
                if ~isa(obj, 'flywheel.model.GearContextLookupItem')
                    obj = flywheel.model.GearContextLookupItem(obj);
                end
                if isKey(obj.props_, 'found')
                end
                if isKey(obj.props_, 'container_type')
                end
                if isKey(obj.props_, 'id')
                end
                if isKey(obj.props_, 'label')
                end
                if isKey(obj.props_, 'value')
                end
            end
        end
    end
end

<aura:application extends="force:slds">
	<c:CaseTemplateAnuj></c:CaseTemplateAnuj>
    <aura:attribute name="options" type="List" default="[
    {'label': 'New', 'value': 'new'},
    {'label': 'In Progress', 'value': 'inProgress'},
    {'label': 'Finished', 'value': 'finished'},
    ]"/>

    <lightning:combobox name="progress"  variant="label-hidden" value="inProgress" placeholder="Select Progress" options="{! v.options }" onchange="{! c.handleChange }"/>
</aura:application>
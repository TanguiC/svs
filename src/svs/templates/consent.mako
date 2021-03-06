<%!
    def list2str(claim):
        # more human-friendly and avoid "u'" prefix for unicode strings in list
        if isinstance(claim, list):
            claim = ", ".join(claim)
        return claim
%>

<%inherit file="base.mako"/>

<%block name="head_title">Consent</%block>
<%block name="page_header">${_("Consent - Your consent is required to continue.")}</%block>
<%block name="extra_inputs">
    <input type="hidden" name="state" value="${self.attr.to_json(state) | u}">
    <input type="hidden" name="released_claims" value="${self.attr.to_json(released_claims) | u}">
</%block>

${_(consent_question)}

<br>
<hr>

<form name="allow_consent" action="${form_action}/allow" method="GET"
      style="float: left">
    <button id="submit_ok" type="submit">${_('Ok, accept')}</button>
    ${extra_inputs()}
</form>
<form name="deny_consent" action="${form_action}/deny" method="GET"
      style="float: left; clear: right;">
    <button id="submit_deny" type="submit">${_('No, cancel')}</button>
    ${extra_inputs()}
</form>

<br>
<br>

<div style="clear: both;">
    % for attribute in released_claims:
        <strong>${_(attribute).capitalize()}</strong><br><pre>    ${released_claims[attribute] | n, list2str}</pre>
    % endfor
</div>
<br>
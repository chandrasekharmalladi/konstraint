# METADATA
# title: PodSecurityPolicies must require all capabilities are dropped
# description: |-
#   Allowing containers privileged capabilities on the node makes it easier
#   for containers to escalate their privileges. As such, this is not allowed
#   outside of Kubernetes controller namespaces.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - policy
#       kinds:
#       - PodSecurityPolicy
package psp_deny_added_caps

import data.lib.core
import data.lib.psps
import data.lib.security
import future.keywords.contains
import future.keywords.if

policyID := "P1009"

violation contains msg if {
	not psp_dropped_all_capabilities

	msg := core.format_with_id(
		sprintf("%s/%s: Does not require droping all capabilities", [core.kind, core.name]),
		policyID,
	)
}

psp_dropped_all_capabilities if {
	some psp
	psps.psps[psp]
	security.dropped_capability(psp, "all")
}

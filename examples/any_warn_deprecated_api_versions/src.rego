# METADATA
# title: Deprecated Deployment and DaemonSet API
# description: |-
#   The `extensions/v1beta1 API` has been deprecated in favor of `apps/v1`. Later versions of Kubernetes
#   remove this API so to ensure that the Deployment or DaemonSet can be successfully deployed to the cluster,
#   the version for both of these resources must be `apps/v1`.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - apps
#       kinds:
#       - DaemonSet
#       - Deployment
package any_warn_deprecated_api_versions

import data.lib.core
import future.keywords.contains
import future.keywords.if
import future.keywords.in

policyID := "P0001"

warn contains msg if {
	core.apiVersion == "extensions/v1beta1"
	resources := ["DaemonSet", "Deployment"]
	core.kind in resources

	msg := core.format_with_id(
		sprintf("API extensions/v1beta1 for %s has been deprecated, use apps/v1 instead.", [core.kind]),
		policyID,
	)
}

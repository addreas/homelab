// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// StateDBQuery StateDB query
//
// swagger:model StateDBQuery
#StateDBQuery: {
	// Index to query against
	index?: string @go(Index)

	// Key to query with. Base64 encoded.
	key?: string @go(Key)

	// LowerBound prefix search or full-matching Get
	lowerbound?: bool @go(Lowerbound)

	// Name of the table to query
	table?: string @go(Table)
}
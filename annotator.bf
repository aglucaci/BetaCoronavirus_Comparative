// #########################
// Imports
// #########################
// Lets load some Imports..

LoadFunctionLibrary ("libv3/tasks/trees.bf");
LoadFunctionLibrary ("libv3/tasks/alignments.bf");
LoadFunctionLibrary ("libv3/convenience/regexp.bf");
LoadFunctionLibrary ("libv3/IOFunctions.bf");
LoadFunctionLibrary("libv3/UtilityFunctions.bf");

// ####################################################################################################
// Declares
// ####################################################################################################
// Set the regular expressions to search for
reg_exp = {{
    "Middle_East",
    "Severe_acute_respiratory_syndrome_coronavirus_2",
    "SARS_coronavirus"
}};

console.log("## ##############################################################");
console.log("## Will search for the following regular expressions");
console.log("## ##############################################################");
console.log(reg_exp);
console.log("");

// Set up the dictionary to label / partition lineages
labels = {
    "Middle_East" : "MERS",
    "SARS_coronavirus" : "SARS",
    "Severe_acute_respiratory_syndrome_coronavirus_2" : "SARS2",
    "blocker" : "blocker_label";
};

console.log("");
console.log("They will be replaced with the following labels");
console.log(labels);
console.log("");

// Create empty dict.
node_labels = {};

// ####################################################################################################
// Main subroutine
// ####################################################################################################
// Load the tree
// /Users/user/Downloads/data_12/fasta/MAY.combined_S.fasta_protein_aligned.cat.merged.compressed.codon.fas.raxml.bestTree

console.log("## ##############################################################");
console.log("## Processing the newick tree");
console.log("## ##############################################################");

//Implement a Keyword Argument for the tree, not just user input request.

KeywordArgument ("tree", "A phylogenetic tree (optionally annotated with {})", null, "Please select a tree file for the data:");

console.log(terms.tree);

tree = trees.LoadAnnotatedTopology (TRUE);
ts = tree[^"terms.trees.newick_with_lengths"];

Topology T = ts;

// This prints the tree.
//console.log (T);

console.log("## ##############################################################");
console.log("## Processing utility");
console.log("## ##############################################################");
console.log("");

utility.ForEachPair (regexp.PartitionByRegularExpressions (BranchName (T,-1), reg_exp), "_regexp_", "_leaves_",
	'
		tag = labels[_regexp_];
        console.log("# Searching for: " + tag);
        
		if (Abs (tag)) {
			utility.ForEach (_leaves_, "_leaf_", "node_labels[_leaf_]=tag");
		}
		
	 '
);

// Modification attempted.
//if (null != tag) {
// utility.ForEach (_leaves_, "_leaf_", "node_labels[_leaf_]=tag");
//}

console.log("");
console.log("## ##############################################################");
console.log ("## Moving to next part (printing partitioned/annotated tree)");
console.log("## ##############################################################");
console.log("");

node_labels * ((trees.ConjunctionLabel ("T", node_labels))["labels"]);

finalTree = tree.Annotate ("T", "relabel_and_annotate", "{}", TRUE);
console.log (finalTree);

console.log("");
console.log("## ##############################################################");
console.log ("## Saving to file");
console.log("## ##############################################################");
console.log("");

KeywordArgument ("output", "Write the resulting PARTITIONED NEWICK to this file (default is to save to the same path as the input tree file + '.partitioned.nwk')", 'TEST');

//KeywordArgument ("output", "Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'FEL.json')", fel.codon_data_info [terms.json.json]);
output = "AAAA";
console.log(output);

// Save this output string
//console.log (finalTree);


// ####################################################################################################
// Helper Functions
// ####################################################################################################

function relabel_and_annotate (node_name) {
    _label = "";
    if (node_labels / node_name) {
        _label = "{" + node_labels[node_name] + "}";
    }
    return node_name + _label;
}

// ####################################################################################################
// END OF FILE
// ####################################################################################################

import json
import csv
import plotly.figure_factory as ff


viruses = ["SARS2", "SARS", "MERS", "HKU1", "OC43", "NL63", "229E"]
genes = ["ORF1b","ORF1a", "E","N", "M", "S"]


out_csv = "MEME_pval_branches.csv"
dnds_csv = "MEME_dnds.csv"
branch_csv = "MEME_branch.csv"
counts_csv = "MEME_counts.csv"

with open(out_csv, "w") as out, open(dnds_csv, "w") as out_dnds,open(branch_csv, "w") as out_branch, open(counts_csv, "w") as out_count:
    writer, dnds_writer, branch_writer, count_writer = csv.writer(out, delimiter=','), csv.writer(out_dnds, delimiter=','), csv.writer(out_branch, delimiter=','), csv.writer(out_count, delimiter=',')

    writer.writerow(["VIRUS", "GENE", "SITE", "p-val", "branches"])
    dnds_writer.writerow(["VIRUS", "GENE", "dnds"])
    branch_writer.writerow(["VIRUS", "GENE", "branch_total"])
    count_writer.writerow(["VIRUS", "GENE", "RAW", "RATIO"])

    for v in viruses:
        for g in genes:
            in_json = 'OCT29_MEME/%s_%s.catted.qa.fasta_protein.aligned.compressed.codon.fas.MEME.json' % (v,g)

            if in_json != 'OCT29_MEME/SARS2_ORF1a.catted.qa.fasta_protein.aligned.compressed.codon.fas.MEME.json':
                print(f"OPENING --> {in_json}")

                with open(str(in_json)) as f:
                    meme_data = json.load(f)


                counts = 0
                other_counts = 0
                for pos, item in enumerate(meme_data["MLE"]["content"]["0"]):
                    p_val, branches = float(item[6]), float(item[7])
                    if float(p_val) <= 0.05:
                        writer.writerow([v,g,pos,p_val,branches])
                        counts += 1
                        #print(f"VIRUS: {v} | GENE: {g} | SITE: {pos + 1} | p_val: {p_val} | branches: {branches}")
                    else:
                        other_counts += 1
                try:
                    dnds = meme_data["fits"]["Global MG94xREV"]["Rate Distributions"]["non-synonymous/synonymous rate ratio for *test*"][0][0]
                    dnds_writer.writerow([v,g,dnds])
                except:
                    dnds = "-1"
                    dnds_writer.writerow([v,g,dnds])


                branch_total = 0
                for item in meme_data["branch attributes"]["0"]:
                    try:
                        #print(item, meme_data["branch attributes"]["0"][item]["Global MG94xREV"])
                        branch_total += float(meme_data["branch attributes"]["0"][item]["Global MG94xREV"])
                    except:
                        continue

                #print(v, g, branch_total)
                branch_writer.writerow([v,g, branch_total])
                count_writer.writerow([v,g,counts, counts/(counts + other_counts))])

            else:
                continue


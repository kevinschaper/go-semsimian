#!/bin/bash


echo "Populate phenio db with GO term association"

sqlite3 -cmd ".mode tabs" monarch-kg.db ".import gencc.tsv gencc"


sqlite3 -cmd "attach 'monarch-kg.db' as monarch" go.db "insert into term_association (id, subject, predicate, object, evidence_type, publication, source) select id, subject, predicate, object, has_evidence as evidence_type, publications as publication, primary_knowledge_source as source from monarch.edges where subject like 'HGNC:%' and object like 'GO:%' and subject in (select distinct gene_curie from monarch.gencc);"



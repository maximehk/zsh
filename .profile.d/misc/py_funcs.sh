#!/bin/bash

csv_pt() {
  python -c 'import pandas,sys;from prettytable import PrettyTable as PT; df=pandas.read_csv(sys.argv[1]); t = PT(df.columns.tolist()); t.align="l"; [t.add_row(x) for x in df.values]; print(t)' $*
}

csv_pt_drop() {
  python -c 'import pandas,sys;from prettytable import PrettyTable as PT; df=pandas.read_csv(sys.argv[1]); df=df.drop(df.columns[int(sys.argv[2])], axis=1); t = PT(df.columns.tolist()); [t.add_row(x) for x in df.values]; print(t)' $*
}

qs() {
  python3 <(cat << HERE
import sys
from pprint import pprint
from urllib.parse import parse_qsl, urlsplit
pprint(dict(parse_qsl(urlsplit(" ".join(sys.argv)).query)))
HERE
  ) -- "$*"
}


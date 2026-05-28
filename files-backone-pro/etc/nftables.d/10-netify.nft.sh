table inet nfa {
    chain forward {
        type filter hook forward priority -150; policy accept;
        ip saddr . tcp dport . ip daddr @nfa_block.v4 reject
        ip saddr . udp dport . ip daddr @nfa_block.v4 reject
        }
}


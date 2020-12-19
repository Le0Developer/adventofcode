
# PCRE limitations

Part 2 (`-b`) reached PCRE's limits and is impossible to be solved by it.  
The builtin library `regex` isn't able to either, so I've to use python as a fallback (python has its own regex implementation).

Really sad that I can't complete every challenge in V only, but I don't plan to remake regex.  
Before trying regex I also tried without, but after hours of trying it was less consistent than regex and had only 11 matches in part 1.

import networkx as nx


# Undirected Graph
G = nx.Graph()
G.add_node(1)
G.add_node(2)
G.add_edge(1,2)
print(G.number_of_nodes())
print(G.number_of_edges())


# Directed Graph
DG = nx.DiGraph()
DG.add_edge(2, 1)   # adds the nodes in order 2, 1
DG.add_edge(1, 3)
DG.add_edge(2, 4)
DG.add_edge(1, 2)
assert list(DG.successors(2)) == [1, 4]
assert list(DG.edges) == [(2, 1), (2, 4), (1, 3), (1, 2)]
print(list(DG.adj[1]))
print(list(DG.edges))

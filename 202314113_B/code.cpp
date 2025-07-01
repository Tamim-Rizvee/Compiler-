#include <bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
#define ROLL_SUM 17
using namespace std;

class Symbol_info
{

public:
    string symbol, symbol_type;
    Symbol_info() {}
    Symbol_info(string sym, string type) : symbol(sym), symbol_type(type) {}
    void show()
    {
        cout << "< " << symbol << " , " << symbol_type << " >";
    }
};

class Symbol_table
{
    vector<vector<Symbol_info>> table;
    int hash_func(string symbol);

public:
    Symbol_table()
    {
        table.resize(100);
    }
    void insert(string symbol, string type)
    {
        int n = hash_func(symbol);
        table[n].push_back(Symbol_info(symbol, type));
        cout << "inserted at position " << n << "," << table[n].size() - 1 << uwu;
    }

    void print()
    {
        for (int i = 0; i < 100; i++)
        {
            if (!table[i].empty())
            {
                for (auto &sym : table[i])
                {
                    cout << i << "-> ";
                    sym.show();
                }
                cout << uwu;
            }
        }
    }

    pair<bool , pair<int , int>>  search(string symbol)
    {
        int n = hash_func(symbol);
        if(table[n].empty())
            return {false, {0, 0}};
        for (int i = 0; i< table[n].size(); i++)
        {
            if(table[n][i].symbol == symbol)
                return {true, {n, i}};
        }
        return {false, {0, 0}};
    }
};

int Symbol_table::hash_func(string symbol)
{
    int siz = symbol.size(), sum = 0;
    if (siz >= 3)
        sum = symbol[0] + symbol[1] + symbol[siz - 2] + symbol[siz - 1];
    else
    {
        for (int i = 0; i < siz; i++)
            sum += symbol[i];
    }
    return ((sum << 3) * ROLL_SUM) % 100;
}

void process_command(Symbol_table &st)
{
    string command, op;
    vector<string> command_store;
    getline(cin, command);
    command_store.clear();
    istringstream iss(command);
    while (iss >> op)
        command_store.push_back(op);
    if (command_store[0] == "I")
        st.insert(command_store[1], command_store[2]);
    else if(command_store[0] == "P")
        st.print();
    else if(command_store[0] == "L")
    {
        auto ans = st.search(command_store[1]);
        if(ans.first)
            cout << "Found at " << ans.second.first << ", " << ans.second.second;
        else
            cout << "Not Found" << uwu;
    }
}

int main()
{
    // Onii_chan;
    Symbol_table st;
    int n;
    cout << "Enter number of symbols to insert: ";
    cin >> n;
    cin.ignore();
    for (int i = 0; i < n; i++)
    {
        process_command(st);
    }
    return 0;
}

#include <bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
#define table_size 100
using namespace std;

// int hash_func(string value)
// {
//     int ans = 0;
//     for (int i = 0; i < 3; i++)
//         ans += value[i];
//     cout << ans << uwu;
//     return (ans * 202314113) % 20;
// }

class symbol_info
{
public:
    string symbol, type;
};

class symbol_table
{
public:
    vector<vector<int>> table;
    symbol_table()
    {
        table.resize(table_size);
    }
    int hash_(string value, int n)
    {
        int ans = 0;
        for (auto x : value)
            ans += x << n;
        return ans % 100;
    }
};

int main()
{
    Onii_chan;
    string s1 = "var_1";
    // cout << hash_func(s1);
    // cout << hash_("int", 3);
    return 0;
}

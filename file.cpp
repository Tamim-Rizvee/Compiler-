#include<bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0),cin.tie(0),cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;
int main()
{
    Onii_chan;

    ofstream newfile("prac.txt");
    newfile << "i am tamimul islam" << uwu;
    newfile << "hiii" << uwu;
    newfile.close();

    ifstream new_file("prac.txt"); 
    string s1;
    while(getline(new_file , s1))
        cout << s1 << uwu;
    new_file.close();
    return 0;
}
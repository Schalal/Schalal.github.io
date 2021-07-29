#include <iostream>
#include"Point.h"
using namespace std;
int main()
{
	Point a(-83.0, 40.0);
	Point b(116.56,39.91);
	cout << a.getDimension()<<endl;
	cout << a.getXYString()<<"\n";
	cout << a.isEqual(b) << "\n";
	cout << a.isDifferent(a) << "\n";
	cout << a.getGreatCircleDistance(b) << endl;
	return 0;
}
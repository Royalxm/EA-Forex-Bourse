//+------------------------------------------------------------------+
//|                                                 Royalland v3.mq4 |
//|                                                       Mohamed N. |
//|                                       https://github.com/Royalxm |
//+------------------------------------------------------------------+
#property copyright "Mohamed N."
#property link      "https://github.com/Royalxm"
#property version   "1.00"
#property strict


struct valeur
{
   double timeopen;
   double price_actuel;
   double time[3];
   double limit_buy;
   double limit_sell;
   double profil; 
};


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
     Print("Bar count on the  ",iBars(NULL,PERIOD_M5));
  }
//+------------------------------------------------------------------+

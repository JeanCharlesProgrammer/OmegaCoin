# OmegaCoin
Omega Coin, the best POS masternode coin.

With this script you can start your masternode easy.

Steps:

1 - Create a new address at you Omega wallet.

2 - Send 1000 omega coins to this address.

3 - After the coin arrived at the masternode address you can generate the genkey and outputs in the debug console with the comands (masternode genkey, masternode outputs). save this data because you will need that bellow.

4 - Update the masternode file by the menu Tools - Open Masternode Configuration file, and edit the content including the data like this(mn1 IPVpsServer:port genkeyValue firstpartOutputValue outputnumber) Note: If you have not a VPS Server created until now, it's time, just create and copy the ip.

5 - Edit the script setup.sh including the genkey generated for you masternode in the line where is wrote Imput_here_genkey_of_your_masternode.

6 - Connect to the VPS Server by Putty.

7 - copy the content of the script edited with your genkey of your masternode and paste inside a file ex: 7.1 - write: vi setup.sh 7.2 - press i (to edit the file) 7.3 - paste the content by pressing the right button of your mouse. 7.4 - press ESC (To skip of the edit of the file) 7.5 - write: :w (to save the changes in the file) 7.6 - write: :q (to quit the file VIM editor)

8 - change the permition of the script by the command: chmod -R 755 setup.sh

9 - execute the script by the command: ,/setup.sh

10 - wait for some minutes until get a final message "Job completed successfully"

11 - check if the wallet is synchronized with the command "omegacoin-cli mnsync status" until get the status "Masternode sync finished"

12 - Go to your windows wallet in the tab masternodes, (if its not showing this tab you have to enable it at the menu settings --> Option and selecting the option "Show masternode tab" in the wallet tab, click ok and restart the wallet) 12.1 - click over the line of your masternode with status missing and click in start alias, after that your masternode status will change to Pre-Enabled or Watchdog-expired.

13 - make a check if the masternode is running in the linux by the command "omegacoin-cli masternode status" The result should be the outputs information and the status should be "Masternode successfully started", you can close the connection with your VPS and let it work for you.

14 - In the windows wallet, wait until status: Enabled and so wait for the first reward.

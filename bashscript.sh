#!/bin/bash

function main() {
	echo "Do you want to encrypt or decrypt the file?"
        echo "Enter 'E' for encryption or 'D' for decryption or 'Q' to quit the program?"
        read condition



function enc(){

	echo "Do you want to encrypt the file with asymmetric key encryption or symmetric key encryption"
                        echo "Enter 'AS' for asymmetric and 'S' for symmetric"
                        read enc
                        if [ -z $enc ]; then
                                echo 'Invalid Input'
                                enc
                        fi
                        if [ "$enc" == 'as' ] || [ "$enc" == 'AS' ]; then
                                echo "Enter the name of your file where you want to keep your encrypted data."
                                read encfile
                                echo "Starting Encryption process"
                                echo "Generating Private key"
                                echo
                                ./load.sh

                                openssl genrsa -out private_key.pem 2048 > privateKey
                                echo
                                echo "Private key generated sucessfully"
                                echo "Generating Public key"
                                ./load.sh
                                openssl rsa -in private_key.pem -out public_key.pem -pubout > publicKey
                                echo
                                echo "Public key generated sucessfully"
                                echo 'Encrypting the file with public key'
                                echo
                                ./load.sh
                                openssl rsautl -encrypt -in $filename -out $encfile -inkey public_key.pem -pubin
                                echo
                                echo "Encryption sucessfull"
                                echo "The encrypted data is"
                                cat $encfile
                        elif [ "$enc" == 's' ] || [ "$enc" == 'S' ]; then
                                echo "Enter the name of your file where you wanto to keep your encrypted data."
                                read encfile
                                 echo "Which algorith do you want to use"
                                echo "aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb
aes-256-cbc       aes-256-ecb       aria-128-cbc      aria-128-cfb
aria-128-cfb1     aria-128-cfb8     aria-128-ctr      aria-128-ecb
aria-128-ofb      aria-192-cbc      aria-192-cfb      aria-192-cfb1
aria-192-cfb8     aria-192-ctr      aria-192-ecb      aria-192-ofb
aria-256-cbc      aria-256-cfb      aria-256-cfb1     aria-256-cfb8
aria-256-ctr      aria-256-ecb      aria-256-ofb      base64
bf                bf-cbc            bf-cfb            bf-ecb
bf-ofb            camellia-128-cbc  camellia-128-ecb  camellia-192-cbc
camellia-192-ecb  camellia-256-cbc  camellia-256-ecb  cast
cast-cbc          cast5-cbc         cast5-cfb         cast5-ecb
cast5-ofb         des               des-cbc           des-cfb
des-ecb           des-ede           des-ede-cbc       des-ede-cfb
des-ede-ofb       des-ede3          des-ede3-cbc      des-ede3-cfb
des-ede3-ofb      des-ofb           des3              desx
rc2               rc2-40-cbc        rc2-64-cbc        rc2-cbc
rc2-cfb           rc2-ecb           rc2-ofb           rc4
rc4-40            seed              seed-cbc          seed-cfb
seed-ecb          seed-ofb          sm4-cbc           sm4-cfb
sm4-ctr           sm4-ecb           sm4-ofb" 

                                echo
                                 read algo
                                 echo 'Choose your password'
                                 read passwd
                                 echo "Encrypting the file"
                                 echo
                                 ./load.sh
                                 echo
                                 openssl $algo -e -in $filename -out $encfile -k $passwd
                                 echo "Encryption sucessfull"
                                 echo "The encrypted file is"
                                 cat $encfile
                        else
                                echo 'Invalid input'
                                enc
            		fi

echo -n "Do you want to decrypt the file(y/n)? :"
read user
if [[ "$user" == "y" ||  "$user" == "Y" ]]; then
	dec
else
	echo "Goodbye!!!"
	exit 0
fi
}

function dec(){
	echo "In which way do you want to decrypt the data?"
                echo "Enter 'AS' for asymmetric or 'S' for symmetric"
                read con2
                if [ -z $con2 ]; then
                        echo "Invalid Input"
                        dec
                fi
                echo
                ls
                echo
                echo "Which file do you want to decrypt?"
                read filename1
                echo "Enter the name of file where you want to store your decrypted data"
                read decfile
                echo
                if [ "$con2" == 'as' ] || [ "$con2" == 'AS' ]; then
                        echo "Decrypting the file"
                        echo
                        ./load.sh
                        echo
                        openssl rsautl -decrypt -in $filename1 -out $decfile -inkey private_key.pem
                        echo "Decryption sucessfull"
                        echo
                        echo "The decrypted data is"
                        cat $decfile

                elif [ "$con2" == 's' ] || [ "$con2" == 'S' ]; then
                        echo "Enter the algorithm of the encrypted file"
                        read algo1
                        echo "Enter the password used to encrypt the file"
                        read passwd1
                        echo "Decrypting the file"
                        echo
			./load.sh
                        echo
                        openssl $algo1 -d -in $filename1 -out $decfile -k $passwd1
                        echo 'Decryption sucessfull'
                        echo
                        echo "The decrypted data is"
                        cat $decfile
                else
                        echo "Invalid Input"
                        dec
                fi

}

if [ -z $condition ]; then
	echo " You've no input"
	main

elif [ "$condition" == "E" ] || [ "$condition" == "e" ] ;then
	echo "Do you want to create a new file for encryption or the file that needs to be encrypted already exists?"

	echo
        echo "a. Create New file
b. Use existing file
Enter a or b"

         read con1
                 
         if [ "$con1" == 'a' ]; then
                         echo "Name of your file: "
                         read filename
                         echo "Creating file"
                         sleep 1
                         ./load.sh
                         touch $filename
                         echo
                         echo "Place your content here: "
                         read content
                         echo "Placing your content"
			 ./load.sh
			 echo "$content" > $filename
			 enc
	elif [ "$con1" == 'b' ]; then
                         echo "Which file do you want to encrypt?"
                         ls
                         echo
                         read filename
			 cat $filename
			 enc
 	else
		echo "Invalid input"
		main
	fi
		


		

elif [ "$condition" == 'D' ] || [ "$condition" == 'd' ] ; then
	dec

elif [ "$condition" == 'Q' ] || [ "$condition" == 'q' ]; then
	echo "!!!GoodBye!!!"
	exit 0

else
	echo "Invalid Input!!!"
	echo " "
	main


fi


}
main

/*

Cleaning Data in SQL Queries

*/

SELECT *
FROM dbo.NashvilleHousing

-----------------------------------------------------------------------------------------------------

--Standardize Date Format

SELECT SaleDate
FROM dbo.NashvilleHousing

SELECT CONVERT(DATE, SaleDate)
FROM dbo.NashvilleHousing

UPDATE dbo.NashvilleHousing
SET SaleDate = CONVERT(DATE, Saledate)

ALTER TABLE dbo.NashvilleHousing
ADD SaleDateConverted Date

UPDATE dbo.NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

SELECT SaleDate, SaleDateConverted
FROM dbo.NashvilleHousing

-----------------------------------------------------------------------------------------------

-- Populate Property Address Data

SELECT *
FROM NashvilleHousing
WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a INNER JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
WHERE a.UniqueID <> b.UniqueID
AND a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a INNER JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
WHERE a.UniqueID <> b.UniqueID
AND a.PropertyAddress IS NULL

------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

SELECT propertyAddress
FROM NashvilleHousing

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing 
ADD PropertySplitCity NVARCHAR(255) 

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

SELECT OwnerAddress
FROM NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress,',','.'), 3),
PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
FROM NashvilleHousing 

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)

ALTER TABLE NashvilleHousing 
ADD OwnerSplitState NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)

----------------------------------------------------------------------------------------

--Change Y and N to Yes and No in "Sold as Vacant" Field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM NashvilleHousing
Group By SoldAsVacant

SELECT CASE 
	WHEN SoldAsVacant = 0 THEN 'No'
	WHEN SoldAsVacant = 1 THEN 'Yes'
	END
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
	WHEN SoldAsVacant = 0 THEN 'No'
	WHEN SoldAsVacant = 1 THEN 'Yes'
	END

--------------------------------------------------------------------------------

--Remove Duplicates

WITH RowNumCTE AS(
SELECT n.*,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID, 
		PropertyAddress, 
		SalePrice, 
		SaleDate, 
		LegalReference 
		ORDER BY 
		UniqueID) Row_Num
FROM NashvilleHousing n
--ORDER BY ParcelID
)
DELETE
FROM RowNumCTE
WHERE Row_Num > 1

--------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

SELECT *
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate










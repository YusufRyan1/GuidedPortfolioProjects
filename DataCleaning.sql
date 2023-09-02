select * from PortfolioProject.dbo.NashvilleHousing


--Standarize Date Format

select SaleDate,CONVERT(date,SaleDate) from PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing

set SaleDate = CONVERT(date,SaleDate)

--UPDATE NashvilleHousing
--SET SaleDate = CAST(SaleDate AS date)

--UPDATE NashvilleHousing
--SET SaleDate = CAST(CONVERT(varchar, SaleDate, 101) AS date)

--UPDATE NashvilleHousing
--SET SaleDate = DATEADD(DAY, DATEDIFF(DAY, 0, SaleDate), 0)

--Alter table nashvilleHousing
--add SaleDateConverted date

--UPDATE NashvilleHousing
--set SaleDateConverted = convert(date,SaleDate)


select SaleDateConverted from PortfolioProject.dbo.NashvilleHousing



--Populating Null Addresses 

select * from NashvilleHousing
where PropertyAddress is null




select a.ParcelID,ISNULL(a.PropertyAddress,b.PropertyAddress) as PropertyAddress,b.ParcelID,b.PropertyAddress 
from NashvilleHousing a
join NashvilleHousing b 
on a.ParcelID=b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]   

where a.PropertyAddress is null

--update a 
--set a.PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
--from NashvilleHousing a
--join NashvilleHousing b 
--on a.ParcelID=b.ParcelID
--and a.[UniqueID ] <> b.[UniqueID ]   

--where a.PropertyAddress is null




--Breaking Down Addresses into City,State

--using substring method 
select 

substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) As Address,
substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(propertyaddress)) As City


from NashvilleHousing

alter table NashvilleHousing
add PropertySplittedAddress Nvarchar(255)


alter table NashvilleHousing
add PropertySplittedCity Nvarchar(255)


 update NashvilleHousing
 set PropertySplittedAddress=substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)
 update NashvilleHousing
 set PropertySplittedCity=substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(propertyaddress))


 --using parsename method -- Note: ParseName recognizes periods "." and doesn't recognize "," and it deals with the the string inversely



 select * from NashvilleHousing

 select parsename (REPLACE(ownerAddress,',','.'),3),parsename (REPLACE(ownerAddress,',','.'),2),parsename (REPLACE(ownerAddress,',','.'),1)
 from NashvilleHousing


 alter table NashvilleHousing
add OwnerSplittedAddress Nvarchar(255)

alter table NashvilleHousing
add OwnerSplittedCity Nvarchar(255)

alter table NashvilleHousing
add OwnerSplittedState Nvarchar(255)

update NashvilleHousing
 set OwnerSplittedAddress= parsename (REPLACE(ownerAddress,',','.'),3)

update NashvilleHousing
 set OwnerSplittedCity= parsename (REPLACE(ownerAddress,',','.'),2)

 update NashvilleHousing
 set OwnerSplittedState= parsename (REPLACE(ownerAddress,',','.'),1)


 --Changing the N and Y to Yes and No in (SoldAsVacant) 
 select distinct SoldAsVacant ,count(soldasvacant)
 from NashvilleHousing
 group by SoldAsVacant
 order by 2

 select SoldAsVacant,
 case 
 when SoldAsVacant='N' Then 'No'
 when SoldAsVacant='Y' Then 'Yes'
 else SoldAsVacant
 end
 from NashvilleHousing

 update NashvilleHousing
 set SoldAsVacant=
  case 
 when SoldAsVacant='N' Then 'No'
 when SoldAsVacant='Y' Then 'Yes'
 else SoldAsVacant
 end


 --Remove Duplicates -- Note: THIS IS NOT A BEST PRACTICE DO NOT DO THIS WITH YOUR DATA 
 WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY 
	ParcelID,
	PropertyAddress,
	SalePrice,
	SaleDate,
	LegalReference
	ORDER BY
	UniqueID
	) row_num

From PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
--delete 
--From RowNumCTE
--Where row_num > 1
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress




Select *
From PortfolioProject.dbo.NashvilleHousing

-- Delete Unused Columns --NOTE: THIS IS NOT A BEST PRACTICE DO NOT DO THIS WITH YOUR DATA

select * from NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate